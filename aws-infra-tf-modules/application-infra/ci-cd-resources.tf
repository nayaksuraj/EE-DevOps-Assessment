locals {
  common_tags = {
    environment = var.environment
    Project     = var.developer
  }
}

########################################################
#    Key pair to be used for SSH access                #
########################################################
resource "tls_private_key" "ci_cd_ssh_data" {
  algorithm = "RSA"
}

resource "aws_key_pair" "ssh_key" {
  key_name   = "ci-cd-admin-key"
  public_key = tls_private_key.ci_cd_ssh_data.public_key_openssh

  tags = merge(local.common_tags, map("Name", "${var.project_name}-ssh-key"))
}

#############################################################
#           Launch Template & ASG Group For CI/CD Node      #
#############################################################
resource "aws_launch_template" "ci_cd_node_lt" {
  name_prefix = "${var.project_name}-lt-${var.environment}"

  update_default_version = true
  image_id               = data.aws_ami.ci-cd-node-ami.id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.ssh_key.key_name

  user_data = base64encode(data.template_file.script.rendered)

  instance_initiated_shutdown_behavior = "terminate"

  iam_instance_profile {
    arn = aws_iam_instance_profile.ci_cd_node_profile.arn
  }

  network_interfaces {
    device_index                = 0
    associate_public_ip_address = false
    security_groups             = [aws_security_group.ci_cd_node_sg.id]
    delete_on_termination       = true
  }

  placement {
    tenancy = "default"
  }

  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_size           = var.volume_size
      volume_type           = var.volume_type
      delete_on_termination = true
    }
  }

  tag_specifications {
    resource_type = "instance"

    tags = merge(local.common_tags, map("Project", "${var.project_name}-cluster"))
  }

  lifecycle {
    create_before_destroy = true
  }
}



resource "aws_autoscaling_group" "ci_cd_node_asg" {
  depends_on = [aws_alb.ci_cd_node_alb]

  name_prefix = "${var.project_name}-asg-${var.environment}"

  vpc_zone_identifier = data.terraform_remote_state.vpc.outputs.private_subnets

  capacity_rebalance = true

  termination_policies      = var.termination_policies
  max_size                  = var.app_asg_max_size
  min_size                  = var.app_asg_min_size
  desired_capacity          = var.app_asg_desired_capacity
  target_group_arns         = [aws_lb_target_group.ci_cd_target_group.arn]
  health_check_grace_period = var.app_asg_health_check_grace_period
  health_check_type         = var.health_check_type
  wait_for_elb_capacity     = var.app_asg_wait_for_elb_capacity
  wait_for_capacity_timeout = var.wait_for_capacity_timeout

  default_cooldown    = var.default_cooldown
  suspended_processes = var.suspended_processes

  launch_template {
    launch_template_id = aws_launch_template.ci_cd_node_lt.id
    version            = aws_launch_template.ci_cd_node_lt.latest_version
  }

  lifecycle {
    create_before_destroy = true
  }

  dynamic "tag" {
    for_each = var.custom_tags
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }
}

#################################################
#                  ELB                          #
#################################################
resource "aws_alb" "ci_cd_node_alb" {
  name = "${var.project_name}-alb"

  load_balancer_type = var.lb_type
  subnets            = data.terraform_remote_state.vpc.outputs.public_subnets
  security_groups    = [aws_security_group.lb_sg.id]
  internal           = var.lb_isInternal
  enable_http2       = "true"
  idle_timeout       = 600

  tags = merge(local.common_tags, map("Name", "${var.project_name}-${var.environment}-lb"))
}

#################################################
#                  ELB Target Group             #
#################################################
resource "aws_lb_target_group" "ci_cd_target_group" {
  name = "${var.project_name}-tg-${var.environment}"

  port        = var.default_target_group_port
  protocol    = "HTTP"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id
  target_type = "instance"

  tags = {
    name = "${var.project_name}-tg"
  }

  health_check {
    enabled             = true
    protocol            = "HTTP"
    healthy_threshold   = 5
    unhealthy_threshold = 5
    timeout             = 5
    interval            = 30
    path                = "/"
    matcher             = "200,301,302"
  }
}

resource "aws_autoscaling_attachment" "ci_cd_node_alb_att" {
  alb_target_group_arn   = aws_lb_target_group.ci_cd_target_group.arn
  autoscaling_group_name = aws_autoscaling_group.ci_cd_node_asg.name
}

#################################################
#                  ELB Listener                 #
#################################################
resource "aws_lb_listener" "ci_cd_alb_listener" {
  load_balancer_arn = aws_alb.ci_cd_node_alb.arn
  port              = var.listener_port
  protocol          = var.listener_protocol

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ci_cd_target_group.arn
  }
}

resource "aws_alb_listener_rule" "ecs_alb_listener_rule" {
  depends_on = [aws_lb_target_group.ci_cd_target_group]

  listener_arn = aws_lb_listener.ci_cd_alb_listener.arn
  priority     = "100"

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ci_cd_target_group.arn
  }

  condition {
    path_pattern {
      values = ["/"]
    }
  }
}