resource "aws_security_group" "app_node_sg" {
  name        = "${var.project_name}-sg"
  description = "Allow traffic from port 8009 and enable SSH"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id

  tags = merge(local.common_tags, map("Name", "${var.project_name}-sg"))
}

resource "aws_security_group_rule" "allow_traffic_from_lb" {
  type                     = "ingress"
  from_port                = 8009
  to_port                  = 8009
  protocol                 = "tcp"
  security_group_id        = aws_security_group.app_node_sg.id
  source_security_group_id = aws_security_group.lb_sg.id
}

resource "aws_security_group_rule" "allow_ssh_traffic" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = aws_security_group.app_node_sg.id
  cidr_blocks       = ["10.0.0.0/24"]
}

resource "aws_security_group_rule" "master_outbound_rule" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.app_node_sg.id
  cidr_blocks       = ["0.0.0.0/0"]
}


#####========================== Security Group for Elastic Load Balancer ===========================#####
resource "aws_security_group" "app_lb_sg" {
  name        = "${var.project_name}-lb-sg"
  description = "load balancer security group"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id

  tags = merge(local.common_tags, map("Name", "${var.project_name}-lb-sg"))
}

resource "aws_security_group_rule" "allow_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = aws_security_group.app_lb_sg.id
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow_outbound_traffic_lb" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.app_lb_sg.id
}
