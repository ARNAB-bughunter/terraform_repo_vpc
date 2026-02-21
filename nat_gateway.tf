# ------------------------------------------------------------------------------
# NAT Gateway
# ------------------------------------------------------------------------------
# Provisions a NAT Gateway so that instances in private subnets can
# initiate outbound connections to the internet (e.g., software updates)
# without being directly reachable from outside.
#
# Components:
#   1. Elastic IP  - A static public IP address assigned to the NAT Gateway.
#   2. NAT Gateway - Placed in the first public subnet; translates private
#                    instance traffic to the Elastic IP for outbound access.
#
# Both resources depend on the Internet Gateway being created first.
# ------------------------------------------------------------------------------

# Elastic IP for the NAT Gateway
resource "aws_eip" "eip_natgw" {
  tags = {
    Name = "homely-test-eip-natgw"
  }
  depends_on = [aws_internet_gateway.igw]
}

# NAT Gateway in the public subnet
resource "aws_nat_gateway" "natgateway" {
  allocation_id = aws_eip.eip_natgw.id
  subnet_id     = aws_subnet.public_subnets[0].id
  tags = {
    Name = "homely-test-natgw"
  }
  depends_on = [aws_internet_gateway.igw]
}