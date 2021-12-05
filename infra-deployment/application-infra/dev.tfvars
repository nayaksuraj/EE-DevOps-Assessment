default_region = "us-east-1"
project_name   = "DevOps-Assessment"
developer      = "Vivek"

app_asg_desired_capacity          = 1
app_asg_health_check_grace_period = 300
app_asg_max_size                  = 3
app_asg_min_size                  = 1
app_asg_wait_for_elb_capacity     = "1"
default_cooldown                  = 900
wait_for_capacity_timeout         = "10m"
suspended_processes               = []
termination_policies              = ["NewestInstance", "Default"]
health_check_type                 = "ELB"

lb_type           = "application"
lb_isInternal     = false
listener_port     = "80"
listener_protocol = "HTTP"

volume_size = "20"
volume_type = "gp2"

default_target_group_port = 8080


instance_type = "t3a.small"