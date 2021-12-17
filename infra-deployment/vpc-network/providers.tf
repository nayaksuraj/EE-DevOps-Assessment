####################################################
#              AWS TF Provider                     #
####################################################
provider "aws" {
  region  = var.default_region
  profile = "default"
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

  backend "local" {
    path = "C://projects//EE//EE-DevOps-Assessment//tf-state-file//vpc-infra-network.tfstate"
  }
}

# used for accessing Account ID and ARN
data "aws_caller_identity" "current" {}