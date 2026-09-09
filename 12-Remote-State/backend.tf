terraform {
  backend "s3" {
    bucket       = "terraform-remote-state-lokendra-2026"
    key          = "12-Remote-State/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
  }
}
