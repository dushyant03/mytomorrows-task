terraform {
  required_version = ">= 1.3.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = var.region
  assume_role {
    role_arn     = "arn:aws:iam::${local.account_id}:role/terraform-role" #to be created in the AWS account with the right permissions
    session_name = "Terraform"
  }
  allowed_account_ids = [
    local.account_id
  ]
}

