terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}


resource "aws_instance" "my_ec2" {
  ami                    = "ami-0c02fb55956c7d316"
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  tags = {
    Name = "terraform-ec2"
  }
}
