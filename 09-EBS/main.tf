data "aws_instance" "current" {
  instance_id = var.instance_id
}

resource "aws_ebs_volume" "practice" {
  availability_zone = data.aws_instance.current.availability_zone
  size              = 5
  type              = "gp3"

  tags = {
    Name = "terraform-ebs-practice"
  }
}

resource "aws_volume_attachment" "practice" {
  device_name = "/dev/sdf"
  volume_id   = aws_ebs_volume.practice.id
  instance_id = var.instance_id
}
