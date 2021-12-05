####################################################
#           CI/CD Node Module Deployment           #
####################################################
module "ci_cd_infra" {
  source = "../../aws-infra-tf-modules/application-infra"

  environment  = var.environment
  developer    = var.developer
  project_name = var.project_name

  default_region = var.default_region

  app_asg_desired_capacity          = var.app_asg_desired_capacity
  app_asg_health_check_grace_period = var.app_asg_health_check_grace_period
  app_asg_max_size                  = var.app_asg_max_size
  app_asg_min_size                  = var.app_asg_min_size
  app_asg_wait_for_elb_capacity     = var.app_asg_wait_for_elb_capacity
  default_cooldown                  = var.default_cooldown
  health_check_type                 = var.health_check_type
  suspended_processes               = var.suspended_processes
  termination_policies              = var.termination_policies

  volume_size   = var.volume_size
  volume_type   = var.volume_type
  instance_type = var.instance_type

  default_target_group_port = var.default_target_group_port

  lb_isInternal             = var.lb_isInternal
  lb_type                   = var.lb_type
  listener_port             = var.listener_port
  listener_protocol         = var.listener_protocol
  wait_for_capacity_timeout = var.wait_for_capacity_timeout
}