# ------------------------------------------------------------------------------
# Subnet Configuration
# ------------------------------------------------------------------------------
# Creates public and private subnets inside the main VPC.
#
# Public subnets  - Host internet-facing resources (bastion server).
#                   Routed through the Internet Gateway.
# Private subnets - Host backend and database servers.
#                   Routed through the NAT Gateway for outbound-only access.
#
# The number of subnets is driven by the length of the CIDR list variables,
# making it easy to add more subnets by appending CIDRs.
# ------------------------------------------------------------------------------

# Public subnet(s) - currently 1 subnet in ap-south-1a (10.0.1.0/24)
resource "aws_subnet" "public_subnets" {
  count             = length(var.public_subnet_cidrs)
  vpc_id            = aws_vpc.main.id
  cidr_block        = element(var.public_subnet_cidrs, count.index)
  region            = var.public_subnet_region
  availability_zone = var.public_subnet_az


  tags = {
    Name = "homely-test-public-subnet ${count.index + 1}"
  }
}

# Private subnet(s) - currently 2 subnets in ap-south-1b
#   Subnet 1: 10.0.2.0/24 (backend)
#   Subnet 2: 10.0.3.0/24 (database)
resource "aws_subnet" "private_subnets" {
  count             = length(var.private_subnet_cidrs)
  vpc_id            = aws_vpc.main.id
  cidr_block        = element(var.private_subnet_cidrs, count.index)
  region            = var.private_subnet_region
  availability_zone = var.private_subnet_az

  tags = {
    Name = "homely-test-private-subnet ${count.index + 1}"
  }
}