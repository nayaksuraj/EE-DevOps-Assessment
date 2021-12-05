variable "default_region" {
  type        = string
  description = "AWS region to deploy resources"
}

#################################################
#       Variables for VPC Networking            #
#################################################
variable "enable_nat_gateway" {
  type        = bool
  description = "NAT gateway flag"
}

variable "cidr_block" {
  type        = string
  description = "CIDR range for vpc"
}

variable "instance_tenancy" {
  type        = string
  description = "Type of instance tenancy required default/dedicated"
}

variable "enable_dns" {
  type        = string
  description = "To use private DNS within the VPC"
}

variable "support_dns" {
  type        = string
  description = "To use private DNS support within the VPC"
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "Private subnet AZs CIDR"
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "Public subnet AZs CIDR"
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

