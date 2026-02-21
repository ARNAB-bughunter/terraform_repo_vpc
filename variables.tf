# ------------------------------------------------------------------------------
# Input Variables
# ------------------------------------------------------------------------------
# Central variable definitions for the entire infrastructure.
# Override these defaults via terraform.tfvars or -var flags at apply time.
# ------------------------------------------------------------------------------


variable "aws_access_key" {
  type      = string
  sensitive = true
}

variable "aws_secret_key" {
  type      = string
  sensitive = true
}

# -------------------------------------------------------
# Public Subnet Variables
# -------------------------------------------------------
# Defines the CIDR ranges, region, and AZ for public subnets.
# Public subnets host internet-facing resources (e.g., bastion server).
# -------------------------------------------------------

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "Public Subnet CIDR values"
  default     = ["10.0.1.0/24"]
}

variable "public_subnet_region" {
  type        = string
  description = "Public Subnet Region"
  default     = "ap-south-1"
}

variable "public_subnet_az" {
  type        = string
  description = "Public Subnet Availability Zone"
  default     = "ap-south-1a"
}

# -------------------------------------------------------
# Private Subnet Variables
# -------------------------------------------------------
# Defines the CIDR ranges, region, and AZ for private subnets.
# Private subnets host backend and database instances that are
# not directly accessible from the internet.
# -------------------------------------------------------

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "Private Subnet CIDR values"
  default     = ["10.0.2.0/24", "10.0.3.0/24"]
}

variable "private_subnet_region" {
  type        = string
  description = "Private Subnet Region"
  default     = "ap-south-1"
}

variable "private_subnet_az" {
  type        = string
  description = "Private Subnet Availability Zone"
  default     = "ap-south-1b"
}

# -------------------------------------------------------
# Public EC2 (Bastion Server) Variables
# -------------------------------------------------------
# Configuration for the bastion host in the public subnet.
# The bastion acts as a secure jump box to reach private instances.
# -------------------------------------------------------

variable "public_ec2_ami" {
  type        = string
  description = "Public EC2 AMI"
  default     = "ami-019715e0d74f695be"
}

variable "public_ec2_instance_type" {
  type        = string
  description = "Public EC2 Instance Type"
  default     = "t3.micro"
}

variable "ec2_ssh_key_name" {
  type        = string
  description = "SSH key pair name used by all EC2 instances"
  default     = "terraform-server-key"
}

variable "public_ec2_volume_size" {
  type        = number
  description = "Public EC2 root volume size in GB"
  default     = 10
}

# -------------------------------------------------------
# Private EC2 Backend Variables
# -------------------------------------------------------
# Configuration for the backend application server placed
# in the first private subnet (10.0.2.0/24).
# -------------------------------------------------------

variable "private_ec2_backend_ami" {
  type        = string
  description = "Private EC2 Backend AMI"
  default     = "ami-019715e0d74f695be"
}

variable "private_ec2_backend_instance_type" {
  type        = string
  description = "Private EC2 Backend Instance Type"
  default     = "t3.micro"
}

variable "private_ec2_backend_volume_size" {
  type        = number
  description = "Private EC2 Backend root volume size in GB"
  default     = 10
}

# -------------------------------------------------------
# Private EC2 Database Variables
# -------------------------------------------------------
# Configuration for the database server placed in the
# second private subnet (10.0.3.0/24).
# -------------------------------------------------------

variable "private_ec2_db_ami" {
  type        = string
  description = "Private EC2 DB AMI"
  default     = "ami-019715e0d74f695be"
}

variable "private_ec2_db_instance_type" {
  type        = string
  description = "Private EC2 DB Instance Type"
  default     = "t3.micro"
}

variable "private_ec2_db_volume_size" {
  type        = number
  description = "Private EC2 DB root volume size in GB"
  default     = 10
}

# -------------------------------------------------------
# FIFO SQS Variable
# -------------------------------------------------------
variable "sqs_fifo_queue_names" {
  type = list(string)
  default = [
    "homely-xlrt-request.fifo",
    "homely-xlrt-state-change-duplicate.fifo",
    "xlrt-homely-test-response.fifo",
    "xlrt-homely-test-state-change.fifo"
  ]
}
