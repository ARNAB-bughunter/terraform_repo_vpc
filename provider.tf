# ------------------------------------------------------------------------------
# Provider Configuration
# ------------------------------------------------------------------------------
# This file configures the Terraform backend and the AWS provider.
# The AWS provider is pinned to version 6.32.1 and targets the
# ap-south-1 (Mumbai) region.
#
# ------------------------------------------------------------------------------

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.32.1"
    }
  }
}

provider "aws" {
  region     = "ap-south-1"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}