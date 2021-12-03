output "vpc_id" {
  value = module.vpc.vpc_id
}

output "vpc_cidr" {
  value = module.vpc.vpc_cidr
}

output "private_subnets" {
  value = module.vpc.private_subnets
}

output "private_cidrs" {
  value = module.vpc.private_cidrs
}

output "public_subnets" {
  value = module.vpc.public_subnets
}

output "public_cidrs" {
  value = module.vpc.public_cidrs
}