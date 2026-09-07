provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "alb_sg" {
  name        = "terraform-alb-sg"
  description = "Security group for Terraform ALB"
  vpc_id      = "vpc-0f1e822883aa9066f"

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_lb_target_group" "app_tg" {
  name     = "terraform-app-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "vpc-0f1e822883aa9066f"

  health_check {
    enabled             = true
    path                = "/"
    protocol            = "HTTP"
    port                = "traffic-port"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
  }
}

resource "aws_lb" "app_alb" {
  name               = "terraform-app-alb"
  internal           = false
  load_balancer_type = "application"

  security_groups = [aws_security_group.alb_sg.id]

  subnets = [
    "subnet-098bdf72de21e9a90",
    "subnet-0a503eda61160c944",
    "subnet-000c923253bc38282"
  ]
}


resource "aws_lb_listener" "app_listener" {
  load_balancer_arn = aws_lb.app_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_tg.arn
  }
}

resource "aws_lb_target_group_attachment" "app_target" {
  target_group_arn = aws_lb_target_group.app_tg.arn
  target_id        = "i-0a42de500325e8771"
  port             = 80
}
