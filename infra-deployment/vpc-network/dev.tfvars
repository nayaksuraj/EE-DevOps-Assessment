default_region = "us-east-1"

cidr_block         = "10.0.0.0/20"      # 4096 IPs, 10.0.0.0 - 10.0.15.255
instance_tenancy   = "default"
enable_dns         = "true"
support_dns        = "true"

private_subnet_cidrs = ["10.0.0.0/24","10.0.2.0/24","10.0.4.0/24"]
public_subnet_cidrs = ["10.0.1.0/24","10.0.3.0/24","10.0.5.0/24"]

developer                 = "Vivek"