output "elb_dns" {
  value = aws_alb.app_node_alb.dns_name
}

output "app_node_ssh_key" {
  value = aws_key_pair.ssh_key.key_name
}

output "app_node_content" {
  value = tls_private_key.app_ssh_data.public_key_openssh
}
