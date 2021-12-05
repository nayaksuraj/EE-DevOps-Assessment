data "terraform_remote_state" "vpc" {
  backend = "local"

  config = {
    path = "${path.module}/../../tf-state-file/vpc-network.tfstate"
  }
}



data "template_file" "script" {
  template = file("scripts/user-data.tpl")
}

data "aws_caller_identity" "current" {}
