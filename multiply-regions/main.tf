provider "aws" {
  region = "eu-central-1"
}

provider "aws" {
  region = "ca-central-1"
  alias  = "Canada"
}

provider "aws" {
  region = "us-east-1"
  alias  = "USA"
}

#-----------------------------------------------------

data "aws_ami" "default_latest_ubuntu" {
  owners      = ["099720109477"]
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}


data "aws_ami" "usa_latest_ubuntu" {
  provider    = aws.USA
  owners      = ["099720109477"]
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

data "aws_ami" "canada_latest_ubuntu" {
  provider    = aws.Canada
  owners      = ["099720109477"]
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

#-----------------------------------------------------

resource "aws_instance" "my_default_server" {
  ami           = data.aws_ami.default_latest_ubuntu.id
  instance_type = "t2.micro"
  tags = {
    Name = "Default Server"
  }
}

resource "aws_instance" "my_usa_server" {
  provider      = aws.USA
  instance_type = "t2.micro"
  ami           = data.aws_ami.usa_latest_ubuntu.id
  tags = {
    Name = "USA Server"
  }
}

resource "aws_instance" "my_canada_server" {
  provider      = aws.Canada
  instance_type = "t2.micro"
  ami           = data.aws_ami.canada_latest_ubuntu
  tags = {
    Name = "Canada Server"
  }
}
