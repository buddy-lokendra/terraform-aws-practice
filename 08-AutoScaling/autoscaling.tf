resource "aws_autoscaling_group" "app" {
  name             = "terraform-asg"
  min_size         = 1
  max_size         = 3
  desired_capacity = 1
  vpc_zone_identifier = [
    "subnet-0a503eda61160c944",
    "subnet-081ba415f83fb6552",
    "subnet-026ad40d005866e43",
    "subnet-098bdf72de21e9a90",
    "subnet-000c923253bc38282"
  ]
  health_check_type = "ELB"
  target_group_arns = [aws_lb_target_group.app.arn]

  launch_template {
    id      = aws_launch_template.app.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "terraform-asg-instance"
    propagate_at_launch = true
  }
}
