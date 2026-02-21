# Terraform VPC Infrastructure — home-test

Terraform configuration that provisions a complete AWS VPC environment in the `ap-south-1` (Mumbai) region.

## Architecture

```
Internet
    │
    ▼
Internet Gateway
    │
    ▼
Public Subnet (10.0.1.0/24) — ap-south-1a
    │   └── Bastion Server (EC2)
    │
    ▼
NAT Gateway
    │
    ▼
Private Subnet 1 (10.0.2.0/24) — ap-south-1b
    │   └── Backend Server (EC2)
    │
Private Subnet 2 (10.0.3.0/24) — ap-south-1b
        └── Database Server (EC2)
```

## Resources Provisioned

| Resource | Description |
|---|---|
| `aws_vpc` | Main VPC (`10.0.0.0/20`) with DNS hostnames enabled |
| `aws_subnet` (public) | 1 public subnet in `ap-south-1a` |
| `aws_subnet` (private) | 2 private subnets in `ap-south-1b` |
| `aws_internet_gateway` | Attached to the VPC for public internet access |
| `aws_nat_gateway` | Allows private instances to reach the internet |
| `aws_route_table` | Separate route tables for public and private subnets |
| `aws_instance` (bastion) | Public EC2 — SSH jump host |
| `aws_instance` (backend) | Private EC2 — application server |
| `aws_instance` (database) | Private EC2 — database server |
| `aws_security_group` | Shared SG allowing SSH (22) and ICMP inbound, all egress |
| `aws_sqs_queue` | 4 FIFO SQS queues for async messaging |

## Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/downloads) >= 1.0
- AWS credentials with permissions to create VPC, EC2, and SQS resources
- An existing EC2 key pair named `terraform-server-key` (or override via variable)

## Usage

1. Clone the repository and navigate to the directory:

   ```bash
   git clone <repo-url>
   cd terraform_repo_vpc
   ```

2. Create a `terraform.tfvars` file with your AWS credentials:

   ```hcl
   aws_access_key = "YOUR_ACCESS_KEY"
   aws_secret_key = "YOUR_SECRET_KEY"
   ```

3. Initialize, plan, and apply:

   ```bash
   terraform init
   terraform plan
   terraform apply
   ```

4. To destroy all resources:

   ```bash
   terraform destroy
   ```

## Variables

| Variable | Default | Description |
|---|---|---|
| `aws_access_key` | — | AWS access key (sensitive) |
| `aws_secret_key` | — | AWS secret key (sensitive) |
| `public_subnet_cidrs` | `["10.0.1.0/24"]` | Public subnet CIDR blocks |
| `public_subnet_az` | `ap-south-1a` | Public subnet availability zone |
| `private_subnet_cidrs` | `["10.0.2.0/24", "10.0.3.0/24"]` | Private subnet CIDR blocks |
| `private_subnet_az` | `ap-south-1b` | Private subnet availability zone |
| `public_ec2_ami` | `ami-019715e0d74f695be` | AMI for the bastion server |
| `public_ec2_instance_type` | `t3.micro` | Instance type for the bastion server |
| `public_ec2_volume_size` | `10` | Root volume size (GB) for bastion server |
| `private_ec2_backend_ami` | `ami-019715e0d74f695be` | AMI for the backend server |
| `private_ec2_backend_instance_type` | `t3.micro` | Instance type for the backend server |
| `private_ec2_backend_volume_size` | `10` | Root volume size (GB) for backend server |
| `private_ec2_db_ami` | `ami-019715e0d74f695be` | AMI for the database server |
| `private_ec2_db_instance_type` | `t3.micro` | Instance type for the database server |
| `private_ec2_db_volume_size` | `10` | Root volume size (GB) for database server |
| `ec2_ssh_key_name` | `terraform-server-key` | SSH key pair name for all EC2 instances |
| `sqs_fifo_queue_names` | *(see variables.tf)* | List of FIFO SQS queue names |

## File Structure

```
.
├── main.tf             # VPC resource
├── provider.tf         # AWS provider and Terraform version config
├── variables.tf        # Input variable definitions
├── subnets.tf          # Public and private subnets
├── internet_gateway.tf # Internet Gateway
├── nat_gateway.tf      # NAT Gateway and Elastic IP
├── route_tables.tf     # Route tables and subnet associations
├── security_group.tf   # Shared security group (SSH + ICMP)
├── ec2.tf              # EC2 instances (bastion, backend, database)
└── sqs.tf              # FIFO SQS queues
```