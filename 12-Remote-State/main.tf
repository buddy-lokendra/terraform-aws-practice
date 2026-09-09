resource "aws_s3_bucket" "remote_state_test" {
  bucket = "terraform-remote-state-test-lokendra-2026"

  tags = {
    Name  = "Terraform Remote State Test"
    Topic = "Remote-State"
  }
}
