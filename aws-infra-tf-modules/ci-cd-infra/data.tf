data "terraform_remote_state" "vpc" {
  backend = "local"

  config = {
    path = "${path.module}/../../tf-state-file/vpc-infra-network.tfstate"
  }
}

data "template_file" "script" {
  template = file("${path.module}/scripts/user-data.tpl")

  vars = {
    TERRAFORM_VER = var.tf_version
  }
}

data "aws_caller_identity" "current" {}
