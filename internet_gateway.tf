# ------------------------------------------------------------------------------
# Internet Gateway
# ------------------------------------------------------------------------------
# Attaches an Internet Gateway (IGW) to the main VPC.
# The IGW enables resources in public subnets to communicate directly
# with the internet (both inbound and outbound traffic).
# ------------------------------------------------------------------------------

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "homely-test-igw"
  }
}