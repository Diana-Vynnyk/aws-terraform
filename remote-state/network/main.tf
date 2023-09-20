provider "aws" {
  region = "eu-central-1"
}

#-----------------------------------------------
resource "aws_s3_bucket" "s3bucket" {
  bucket = "s3-bucket-for-remote-state-practice"
  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_versioning" "s3versioning" {
  bucket = aws_s3_bucket.s3bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}
/*
resource "aws_s3_bucket_server_side_encryption_configuration" "s3encryption" {
  bucket = aws_s3_bucket.s3bucket.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.mykey.arn
      sse_algorithm     = "aws:kms"
    }
  }
}
*/
output "s3bucketid" {
  value = aws_s3_bucket.s3bucket.id
}


#-----------------------------------------------
/*
terraform {
  backend "s3" {
    bucket     = aws_s3_bucket.s3bucket.id
    key        = "dev/network/terraform.tfstate"
    region     = aws_s3_bucket.s3bucket.region
    depends_on = [aws_s3_bucket.s3bucket]
  }
}
*/
#-----------------------------------------------

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "My VPC"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
}
