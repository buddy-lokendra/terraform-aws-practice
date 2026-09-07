resource "aws_cloudwatch_log_group" "app_logs" {
  name              = "/terraform/practice/app"
  retention_in_days = 7
}

resource "aws_cloudwatch_log_stream" "app_stream" {
  name           = "application-stream"
  log_group_name = aws_cloudwatch_log_group.app_logs.name
}

resource "aws_cloudwatch_metric_alarm" "high_cpu" {
  alarm_name          = "terraform-high-cpu"
  alarm_description   = "Alarm when EC2 CPU usage is high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 300
  statistic           = "Average"
  threshold           = 70

  dimensions = {
    InstanceId = "i-0a42de500325e8771"
  }
}

