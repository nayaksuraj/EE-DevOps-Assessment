#####=============Local variables===============#####
locals {
  common_tags = {
    environment = var.environment
    Project     = var.developer
  }
}

#################################################
#          VPC Network Configuration            #
#################################################
resource "aws_vpc" "devOps_assessment" {

  cidr_block = var.cidr_block
  enable_dns_hostnames = var.enable_dns
  enable_dns_support = var.support_dns
  instance_tenancy = var.instance_tenancy

  tags = merge(local.common_tags, tomap({"Name"= "vpc-${var.environment}-${var.cidr_block}"}))
}