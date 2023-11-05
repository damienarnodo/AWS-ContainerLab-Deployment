variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}

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