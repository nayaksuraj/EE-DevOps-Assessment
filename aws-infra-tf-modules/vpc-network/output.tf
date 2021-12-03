output "vpc_id" {
  value = aws_vpc.devOps_assessment.id
}

output "vpc_cidr" {
  value = aws_vpc.devOps_assessment.cidr_block
}

output "private_subnets" {
  value = aws_subnet.private_subnet.*.id
}

output "private_cidrs" {
  value = aws_subnet.private_subnet.*.cidr_block
}

output "public_subnets" {
  value = aws_subnet.public_subnet.*.id
}

output "public_cidrs" {
  value = aws_subnet.public_subnet.*.cidr_block
}