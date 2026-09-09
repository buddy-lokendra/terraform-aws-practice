output "instance_ids" {
  description = "EC2 instance IDs"
  value       = module.ec2[*].instance_id
}

output "public_ips" {
  description = "EC2 public IPs"
  value       = module.ec2[*].public_ip
}

output "instance_names" {
  description = "EC2 instance names"
  value       = module.ec2[*].instance_name
}
