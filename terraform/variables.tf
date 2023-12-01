variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable "AWS_KEY_NAME" {}
variable "AWS_KEY_LOCATION" {}
variable "AWS_R53_ZONE_ID" {}

variable "GITHUB_REPO_URL" {
  type    = string
  default = ""
}

variable "AWS_REGION" {
  type    = string
  default = "eu-west-3"
}

variable "AWS_AMIS" {
  type = map(any)
  default = {
    "eu-west-3" = "ami-087da76081e7685da"
  }
}

variable "instance_type" {
  type = string
  default = "t2.xlarge"
}