######################################################
#      NAT gateway requires an Elastic IP            #
######################################################
resource "aws_eip" "nat_gw_eip" {
  depends_on = [aws_internet_gateway.vpc_igw]

  vpc = true

  tags = merge(local.common_tags, tomap({"Name"= "eip-${var.environment}-${aws_vpc.devOps_assessment.id}"}))
}


#################################################
#       Create NatGateway and allocate EIP      #
#################################################
resource "aws_nat_gateway" "nat_gateway" {
  depends_on = [aws_internet_gateway.vpc_igw]

  allocation_id = aws_eip.nat_gw_eip.id
  subnet_id     = aws_subnet.public_subnet.*.id[count.index]

  tags = merge(local.common_tags, tomap({"Name"= "nat_gw-${var.environment}-${aws_vpc.devOps_assessment.id}-${count.index}"}))
}

######################################################
#    Create route table for private subnets          #
######################################################
resource "aws_route_table" "private_rt" {
  count  = local.used_azs

  vpc_id = aws_vpc.devOps_assessment.id

  tags = merge(local.common_tags, tomap({"Name"= "pvt_rt-${var.environment}-${aws_vpc.devOps_assessment.id}-${count.index}"}))
}

resource "aws_route" "private_nat_gateway" {
  count = local.used_azs

  route_table_id         = aws_route_table.private_rt.*.id[count.index]
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gateway.id
}

resource "aws_route_table_association" "private_rt_association" {
  count = local.used_azs

  route_table_id = aws_route_table.private_rt.*.id[count.index]
  subnet_id      = aws_subnet.private_subnet.*.id[count.index]
}


#############################################################################
# Route the public subnet traffic through the Internet Gateway              #
#############################################################################
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.devOps_assessment.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpc_igw.id
  }

  tags = merge(local.common_tags, tomap({"Name"= "pub_rt-${var.environment}-${aws_vpc.devOps_assessment.id}"}))
}

resource "aws_route_table_association" "public_rt_association" {
  count = local.used_azs

  route_table_id = aws_route_table.public_rt.id
  subnet_id      = aws_subnet.public_subnet.*.id[count.index]
}


######################################################################
# 2 Public subnets each subnet in a different AZs to achieve HA      #
######################################################################
resource "aws_subnet" "public_subnet" {
  count = local.used_azs

  cidr_block              = var.public_subnet_cidrs[count.index]
  vpc_id                  = aws_vpc.devOps_assessment.id
  availability_zone       = local.list_of_azs[count.index]
  map_public_ip_on_launch = true

  tags = merge(local.common_tags, tomap({"Name"= "pub_subnet-${var.environment}-${element(local.list_of_azs, count.index)}"}))
}


########################################################################
# 2 Private subnets each subnet in a different AZs to achieve HA       #
########################################################################
resource "aws_subnet" "private_subnet" {
  count = local.used_azs

  cidr_block              = var.private_subnet_cidrs[count.index]
  vpc_id                  = aws_vpc.devOps_assessment.id
  availability_zone       = local.list_of_azs[count.index]
  map_public_ip_on_launch = false

  tags = merge(local.common_tags, tomap({"Name"= "pvt_subnet-${var.environment}-${element(local.list_of_azs, count.index)}"}))
}
