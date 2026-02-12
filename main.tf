terraform {
  # After running once with local state, uncomment this block to migrate
  # backend "s3" {
  #   bucket         = "my-org-opentofu-state-123456789012"
  #   key            = "org/v1/terraform.tfstate"
  #   region         = "us-east-1"
  #   dynamodb_table = "opentofu-state-locks"
  #   encrypt        = true
  # }

  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = "us-east-2"
}

module "oidc" {
  source = "./modules/oidc"
}

module "organization" {
  source = "./modules/organization"
}

module "bootstrap" {
  source = "./modules/bootstrap"
}
