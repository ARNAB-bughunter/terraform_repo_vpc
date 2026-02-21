# ------------------------------------------------------------------------------
# EC2 Instances
# ------------------------------------------------------------------------------
# Provisions three EC2 instances across the VPC:
#
#   1. public_ec2   - Bastion (jump) server in the public subnet.
#                     Used to SSH into private instances securely.
#   2. private_ec2_1 - Backend application server in private subnet 1.
#   3. private_ec2_2 - Database server in private subnet 2.
#
# All instances share the same SSH key pair and security group.
# ------------------------------------------------------------------------------

# Bastion server - public subnet, serves as the SSH entry point to the VPC
resource "aws_instance" "public_ec2" {
  ami                         = var.public_ec2_ami
  instance_type               = var.public_ec2_instance_type
  subnet_id                   = aws_subnet.public_subnets[0].id
  vpc_security_group_ids      = [aws_security_group.ssh_icmp_sg.id]
  associate_public_ip_address = true
  key_name                    = var.ec2_ssh_key_name
  root_block_device {
    volume_size = var.public_ec2_volume_size
  }


  tags = {
    Name = "Public EC2 Bastion Server"
  }
}

# Backend application server - private subnet 1 (10.0.2.0/24)
resource "aws_instance" "private_ec2_1" {
  ami                         = var.private_ec2_backend_ami
  instance_type               = var.private_ec2_backend_instance_type
  subnet_id                   = aws_subnet.private_subnets[0].id
  vpc_security_group_ids      = [aws_security_group.ssh_icmp_sg.id]
  associate_public_ip_address = true
  key_name                    = var.ec2_ssh_key_name
  root_block_device {
    volume_size = var.private_ec2_backend_volume_size
  }


  tags = {
    Name = "Private EC2 Backend"
  }
}

# Database server - private subnet 2 (10.0.3.0/24)
resource "aws_instance" "private_ec2_2" {
  ami                         = var.private_ec2_db_ami
  instance_type               = var.private_ec2_db_instance_type
  subnet_id                   = aws_subnet.private_subnets[1].id
  vpc_security_group_ids      = [aws_security_group.ssh_icmp_sg.id]
  associate_public_ip_address = true
  key_name                    = var.ec2_ssh_key_name
  root_block_device {
    volume_size = var.private_ec2_db_volume_size
  }


  tags = {
    Name = "Private EC2 DB"
  }
}