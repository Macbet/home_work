locals {
  name     = "home_work_vpc"
  region   = "eu-west-3"
  vpc_cidr = "10.0.0.0/16"
  azs      = slice(data.aws_availability_zones.available.names, 0, 1)
  tags = {
    Name      = local.name
    Temporary = "true"
    ManagedBy = "Terraform"
    Owner     = "DevOps Team"
  }
  ami = "ami-064508e7b69710843" # eu-west-3 ubuntu 20.04
  ssh_user_data = <<EOT
#!/bin/bash
apt-get update -y
apt-get install -y nginx
systemctl enable nginx
systemctl start nginx
echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEx1PdxeT0zqqQ/Kz0wbgmys6UcecGKqVH62CHTLfOCP dkivenko@macbook" >> /home/ubuntu/.ssh/authorized_keys
  EOT
}