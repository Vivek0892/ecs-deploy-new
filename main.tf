# ---------------------------------------------------------------------------------------------------------------------
# AWS PROVIDER FOR TF CLOUD
# ---------------------------------------------------------------------------------------------------------------------
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  backend "s3" {
    # Setting variables in the backend section isn't possible as of now, see https://github.com/hashicorp/terraform/issues/13022
    bucket = "tf-backend-state-ecs-urolime-demo-2023"
    encrypt = true
    dynamodb_table = "tf-backend-lock-ecs-urolime-demo-2023"
    key = "terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = var.aws_region
  profile = var.aws_profile
}






