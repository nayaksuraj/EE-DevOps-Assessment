default_region = "us-east-1"

enable_nat_gateway = true

cidr_block         = "10.0.0.0/24"                              # 256 IPs, 10.5.0.0 - 10.5.0.254
instance_tenancy   = "default"
enable_dns         = "true"
support_dns        = "true"

private_subnet_cidrs = ["10.0.0.0/26","10.0.0.64/26"]           # 62 IPs in each subnet
public_subnet_cidrs = ["10.0.0.128/26","10.0.0.192/26"]

developer                 = "Vivek"