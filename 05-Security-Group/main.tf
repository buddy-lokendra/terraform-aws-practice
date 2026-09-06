resource "aws_security_group" "web_sg" {
  name        = "terraform-web-sg"
  description = "Security group for Terraform web server"
  vpc_id      = "vpc-0f1e822883aa9066f"

  ingress {
    description = "Allow SSH from trusted IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["54.90.119.31/32"]
  }

  ingress {
    description = "Allow HTTP from internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTPS from internet"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "terraform-web-sg"
  }
}


data "aws_instance" "existing_ec2" {
  instance_id = "i-0a42de500325e8771"
}


resource "aws_network_interface_sg_attachment" "web_sg_attachment" {
  security_group_id    = aws_security_group.web_sg.id
  network_interface_id = data.aws_instance.existing_ec2.network_interface_id
}
