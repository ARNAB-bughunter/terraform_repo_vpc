# ------------------------------------------------------------------------------
# Route Tables & Associations
# ------------------------------------------------------------------------------
# Defines routing rules that control how traffic flows in and out of each subnet.
#
# Public Route Table  - Sends all internet-bound traffic (0.0.0.0/0) through
#                       the Internet Gateway, giving public subnets direct
#                       internet access.
# Private Route Table - Sends all internet-bound traffic (0.0.0.0/0) through
#                       the NAT Gateway, allowing private subnets outbound-only
#                       internet access.
# Default Route Table - Tags the VPC's auto-created main route table for
#                       visibility in the AWS console.
# ------------------------------------------------------------------------------

# Public route table - routes internet traffic via the Internet Gateway
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "homely-test-public-rt"
  }
}

# Associate each public subnet with the public route table
resource "aws_route_table_association" "public_subnet_asso" {
  count          = length(var.public_subnet_cidrs)
  subnet_id      = element(aws_subnet.public_subnets[*].id, count.index)
  route_table_id = aws_route_table.public_rt.id
}

# Private route table - routes internet traffic via the NAT Gateway
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.natgateway.id
  }

  tags = {
    Name = "homely-test-private-rt"
  }
}

# Associate each private subnet with the private route table
resource "aws_route_table_association" "private_subnet_asso" {
  count          = length(var.private_subnet_cidrs)
  subnet_id      = element(aws_subnet.private_subnets[*].id, count.index)
  route_table_id = aws_route_table.private_rt.id
}

# Tag the VPC's default (main) route table for console visibility
resource "aws_default_route_table" "main_rt" {
  default_route_table_id = aws_vpc.main.default_route_table_id

  tags = {
    Name = "homely-main-rt"
  }
}