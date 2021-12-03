####################################################
#              AWS TF Provider                     #
####################################################
provider "aws" {
  region = var.default_region
}


############################################################
# Terraform configuration block is used to define provider #
############################################################
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=3.3.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 1.3"
    }
    template = {
      source  = "hashicorp/template"
      version = "~> 2.1"
    }
  }
  required_version = ">= 0.13"


  backend "s3" {
    region  = "us-east-1"
    encrypt = "true"
  }

}

# used for accessing Account ID and ARN
data "aws_caller_identity" "current" {}