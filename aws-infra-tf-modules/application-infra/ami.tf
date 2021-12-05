data "aws_ami" "ci-cd-node-ami" {
  most_recent = true
  owners      = ["self"]

  filter {
    name   = "name"
    values = ["ci-cd-node-*"]
  }
}