module "ec2-sg" {
  source      = "terraform-aws-modules/security-group/aws"
  version     = "4.0.0"
  name        = "${local.name}-sg"
  description = "Security group for ${local.name} ec2"
  vpc_id      = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
    # open ssh to all
    {
      rule        = "ssh-tcp"
      cidr_blocks = "0.0.0.0/0" # TODO: change to vpn cidr
    },
    # open http-80 to all
    {
      rule        = "http-80-tcp"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
  # open all outbound traffic
  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      description = "Allow all outbound traffic"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
  tags = local.tags
}
