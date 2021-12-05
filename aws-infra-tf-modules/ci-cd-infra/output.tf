output "elb_dns" {
  value = aws_alb.ci_cd_node_alb.dns_name
}

output "ci_cd_node_role" {
  value = aws_iam_role.ci_cd_node_access_role.arn
}

output "ci_cd_node_sg" {
  value = aws_security_group.ci_cd_node_sg.id
}

output "ci_cd_node_ssh_key" {
  value = aws_key_pair.ssh_key.key_name
}

output "ci_cd_node_content" {
  value = tls_private_key.ci_cd_ssh_data.public_key_openssh
}

output "ci_cd_iam_profile" {
  value = aws_iam_instance_profile.ci_cd_node_profile.arn
}