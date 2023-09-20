provider "aws" {
  region = "eu-central-1"
}

resource "aws_iam_user" "user1" {
  name = "diana1"
}

variable "aws_users" {
  description = "List of IAM Users to create"
  default     = ["diana", "diana2", "diana3"]
}

resource "aws_iam_user" "users" {
  count = length(var.aws_users)
  name  = element(var.aws_users, count.index)
}

resource "aws_instance" "servers" {
  count         = 3
  ami           = "ami-0b9094fa2b07038b8"
  instance_type = "t2.micro"
  tags = {
    Name = "Server Number ${count.index + 1}"
  }
}
