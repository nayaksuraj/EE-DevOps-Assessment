output "elb_dns" {
  value = module.application_infra.elb_dns
}

output "app_node_ssh_key" {
  value = module.application_infra.app_node_ssh_key
}

output "app_node_content" {
  value = module.application_infra.app_node_content
}
