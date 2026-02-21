# ------------------------------------------------------------------------------
# Security Group
# ------------------------------------------------------------------------------
# Creates a security group shared by all EC2 instances in this VPC.
#
# Inbound rules:
#   - SSH  (TCP/22)  from 0.0.0.0/0 - allows remote shell access.
#   - ICMP (ping)    from 0.0.0.0/0 - allows connectivity testing.
#
# Outbound rules:
#   - All traffic to 0.0.0.0/0 - unrestricted egress.
#
# ------------------------------------------------------------------------------

resource "aws_security_group" "ssh_icmp_sg" {
  name        = "ssh-icmp-sg"
  description = "Allow SSH and ICMP from anywhere"
  vpc_id      = aws_vpc.main.id

  # Allow inbound SSH access on port 22
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow inbound ICMP (ping) for connectivity checks
  ingress {
    description = "ICMP (ping)"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ssh-icmp-sg"
  }
}
