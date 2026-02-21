# ------------------------------------------------------------------------------
# VPC Configuration
# ------------------------------------------------------------------------------
# Creates the main Virtual Private Cloud (VPC) for the "homely-test" environment.
# - CIDR block 10.0.0.0/20 provides 4,096 usable IP addresses.
# - DNS hostnames are enabled so EC2 instances receive public DNS names.
# ------------------------------------------------------------------------------

resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/20"
  enable_dns_hostnames = true
  tags = {
    Name = "homely-test-vpc"
  }
}