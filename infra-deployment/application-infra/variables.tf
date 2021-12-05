variable "project_name" {
  type        = string
  description = "DevOps Assessment"
}

variable "default_region" {
  type        = string
  description = "AWS region to deploy resources"
}


variable "instance_type" {
  type        = string
  description = "EC2 instance type to create CI/CD instance"
}

variable "tf_version" {
  type = string
  description = "Terraform version to install"
}

######################################################
# Local variables defined                            #
######################################################
variable "developer" {
  type        = string
  description = "Developer name/email"
}

variable "environment" {
  type        = string
  description = "Environment to be used"
}

variable "volume_type" {
  type        = string
  description = "EBS volume type"
}


variable "volume_size" {
  type        = number
  description = "EBS volume size"
}


#####==============================ASG Configuration Variables ============================#####
variable "termination_policies" {
  description = "A list of policies to decide how the instances in the auto scale group should be terminated"
  type        = list(string)
}

variable "app_asg_max_size" {
  type        = string
  description = "ASG max size"
}

variable "app_asg_min_size" {
  type        = string
  description = "ASG min size"
}

variable "app_asg_desired_capacity" {
  type        = string
  description = "ASG desired capacity"
}

variable "app_asg_health_check_grace_period" {
  type        = string
  description = "ASG health check grace period"
}

variable "health_check_type" {
  type        = string
  description = "ASG health check type"
}

variable "app_asg_wait_for_elb_capacity" {
  type        = string
  description = "ASG waih for ELB capacity"
}

variable "default_cooldown" {
  type        = number
  description = "Cool-down value of ASG"
}

variable "suspended_processes" {
  description = "The allowed values are Launch, Terminate, HealthCheck, ReplaceUnhealthy, AZ-Rebalanced, AlarmNotification, ScheduledActions, AddToLoadBalancer"
  type        = list(string)
}

variable "wait_for_capacity_timeout" {
  description = "A maximum duration that Terraform should wait for ASG instances to be healthy before timing out"
  type        = string
}

#####=============ASG Standards Tags===============#####
variable "custom_tags" {
  description = "Custom tags to set on the Instances in the ASG"
  type        = map(string)
  default = {
    Developer = "Vivek"
    Name      = "CI-CD-Node"
    Project   = "DevOps-Assessment"
  }
}

#####================================ELB Configuration Variables=============================#####
variable "lb_type" {
  type        = string
  description = "AWS Loadbalancer type to deploy"
}

variable "lb_isInternal" {
  type        = bool
  description = "Flag for ELB Internal / Public"
}

variable "listener_port" {
  type        = string
  description = "ELB listener PORT, 80, 443"
}

variable "listener_protocol" {
  type        = string
  description = "ELB listener protocol HTTP, HTTPS"
}

variable "default_target_group_port" {
  type        = number
  description = "Target group port for ECS Cluster"
}
