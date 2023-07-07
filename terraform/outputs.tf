# export ec2 public ip 
output "ec2_public_ip" {
  description = "The public IP address assigned to the instance"
  value       = module.ec2.public_ip
}
