provider "aws" {
  region = "us-east-1"
}

resource "aws_db_instance" "mysql" {
  identifier        = "terraform-mysql-db"
  engine            = var.db_engine
  engine_version    = var.db_engine_version
  instance_class    = "db.t3.micro"
  allocated_storage = 20

  db_name  = "terraformdb"
  username = "admin"
  password = "Terraform12345"

  skip_final_snapshot = true
}
