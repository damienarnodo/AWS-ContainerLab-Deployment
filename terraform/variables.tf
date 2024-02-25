variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable "AWS_KEY_NAME" {}
variable "AWS_KEY_LOCATION" {}

variable "AWS_LOCAL_IP" {
  type = string
  default = "0.0.0.0/0"
}

variable "AWS_REGION" {
  type    = string
  default = "eu-west-3"
}

variable "AWS_AMI" {
  type = map(any)
  default = {
    "eu-west-3" = "ami-087da76081e7685da"
  }
}

variable "INSTANCE_TYPE" {
  type    = string
  default = "t2.xlarge"
}