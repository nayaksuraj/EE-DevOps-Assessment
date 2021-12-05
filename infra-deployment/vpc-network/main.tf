####################################################
#           VPC Network Module Deployment          #
####################################################
module "vpc" {
  source = "../../aws-infra-tf-modules/vpc-network"

  environment = var.environment
  developer   = var.developer

  default_region     = var.default_region
  enable_nat_gateway = var.enable_nat_gateway

  cidr_block       = var.cidr_block
  enable_dns       = var.enable_dns
  support_dns      = var.support_dns
  instance_tenancy = var.instance_tenancy

  private_subnet_cidrs = var.private_subnet_cidrs
  public_subnet_cidrs  = var.public_subnet_cidrs
}