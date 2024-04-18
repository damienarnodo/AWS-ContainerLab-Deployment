provider "aws" {
  region     = var.AWS_REGION
  access_key = var.AWS_ACCESS_KEY
  secret_key = var.AWS_SECRET_KEY
}

terraform {
  backend "s3" {
    bucket = "terraform-backend"
    key    = "containerlab/terraform.tfstate"
    region = "eu-west-3"
  }
}