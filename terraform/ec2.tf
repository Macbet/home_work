module "ec2" {
  source                      = "terraform-aws-modules/ec2-instance/aws"
  version                     = "5.2.1"
  name                        = "${local.name}-ec2"
  ami                         = local.ami
  instance_type               = "m5a.large"
  availability_zone           = element(local.azs, 0)                 # fix to first az
  subnet_id                   = element(module.vpc.public_subnets, 0) # fix to first public subnet
  user_data                   = base64encode(local.ssh_user_data) # encode user data to base64
  user_data_replace_on_change = true # to force update
  key_name                    = module.ec2-keypair.key_pair_name # use keypair module
  associate_public_ip_address = true
  vpc_security_group_ids      = [module.ec2-sg.security_group_id] # use security group module
  enable_volume_tags          = false
  root_block_device = [{
    volume_size           = 20
    volume_type           = "gp3"
    encrypted             = true # encrypt root volume
    delete_on_termination = true # delete root volume on instance termination
  }]
}
