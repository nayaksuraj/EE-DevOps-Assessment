output "elb_dns" {
  value = module.ci_cd_infra.elb_dns
}

output "ci_cd_node_role" {
  value = module.ci_cd_infra.ci_cd_node_role
}

output "ci_cd_node_sg" {
  value = module.ci_cd_infra.ci_cd_node_sg
}

output "ci_cd_node_ssh_key" {
  value = module.ci_cd_infra.ci_cd_node_ssh_key
}

output "ci_cd_node_content" {
  value = module.ci_cd_infra.ci_cd_node_content
}

output "ci_cd_iam_profile" {
  value = module.ci_cd_infra.ci_cd_iam_profile
}