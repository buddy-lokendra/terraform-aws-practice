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

resource "aws_iam_user" "dev_user" {
  name = "terraform-practice-user"

  tags = {
    Name        = "terraform-practice-user"
    Environment = "practice"
  }
}


resource "aws_iam_policy" "s3_read_policy" {
  name        = "terraform-s3-read-policy"
  description = "Allow read-only access to S3"

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Action = [
          "s3:GetObject",
          "s3:ListBucket"
        ]

        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_user_policy_attachment" "s3_read_policy_attachment" {
  user       = aws_iam_user.dev_user.name
  policy_arn = aws_iam_policy.s3_read_policy.arn
}


resource "aws_iam_group" "devops_team" {
  name = "devops-team"
}


resource "aws_iam_group_policy_attachment" "devops_team_s3_read" {
  group      = aws_iam_group.devops_team.name
  policy_arn = aws_iam_policy.s3_read_policy.arn
}


resource "aws_iam_user_group_membership" "devops_team_membership" {
  user = aws_iam_user.dev_user.name

  groups = [
    aws_iam_group.devops_team.name
  ]
}

resource "aws_iam_role" "ec2_role" {
  name = "terraform-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "ec2.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name        = "terraform-ec2-role"
    Environment = "practice"
  }
}


resource "aws_iam_role_policy_attachment" "ec2_role_s3_read" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.s3_read_policy.arn
}


resource "aws_iam_instance_profile" "ec2_profile" {
  name = "terraform-ec2-profile"
  role = aws_iam_role.ec2_role.name
}
