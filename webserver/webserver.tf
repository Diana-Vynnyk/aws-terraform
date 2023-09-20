provider "aws" {}

resource "aws_default_vpc" "default" {}

resource "aws_eip" "my_static_ip" {
  instance = aws_instance.my_webserver.id
  domain   = "vpc"
  tags = {
    Name  = "Web Server IP"
    Owner = "Diana Vynnyk"
  }
}

resource "aws_instance" "my_webserver" {
  ami                    = "ami-0b9094fa2b07038b8"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.my_webserver.id]


  tags = {
    Name  = "Web Server Build by Terraform"
    Owner = "Diana Vynnyk"
  }

  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_security_group" "my_webserver" {
  name        = "WebServer Dynamic Security Group"
  description = "Dynamic SecurityGroup for WebServer"
  vpc_id      = aws_default_vpc.default.id

  dynamic "ingress" {
    for_each = ["80", "443", "8080"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.10.0.0/16"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "Web Server Dynamic SecurityGroup"
    Owner = "Diana Vynnyk"
  }
}







