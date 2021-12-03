#####=============Local variables===============#####
data "aws_availability_zones" "available" {}

locals {
  common_tags = {
    environment = var.environment
    Project     = var.developer
  }

  list_of_azs = data.aws_availability_zones.available.names
  total_azs = length(data.aws_availability_zones.available.names)
  used_azs = local.total_azs > 3 ? 2 : local.total_azs
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

#######################################################
#         Enable access to or from the Internet       #
#######################################################
resource "aws_internet_gateway" "vpc_igw" {
  vpc_id = aws_vpc.devOps_assessment.id

  tags = merge(local.common_tags, tomap({"Name"= "igw-${var.environment}"}))
}

#######################################################
#               VPC Main Route Table                  #
#######################################################
resource "aws_route_table" "vpc_main_rt" {
  vpc_id = aws_vpc.devOps_assessment.id
  tags   = merge(local.common_tags, tomap({"Name"= "vpc-${var.environment}-main-rt"}))
}

resource "aws_main_route_table_association" "main_rt_vpc_association" {
  route_table_id = aws_route_table.vpc_main_rt.id
  vpc_id         = aws_vpc.devOps_assessment.id
}