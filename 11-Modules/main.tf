module "ec2" {
  count = 2

  source = "./modules/ec2"

  ami_id        = var.ami_id
  instance_type = var.instance_type
  instance_name = "terraform-module-ec2-${count.index + 1}"
}
