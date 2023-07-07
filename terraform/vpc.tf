
# get aws available zones
data "aws_availability_zones" "available" {}


module "vpc" {
  source               = "terraform-aws-modules/vpc/aws"
  version              = "5.0.0"
  name                 = local.name
  cidr                 = local.vpc_cidr
  azs                  = local.azs
  # on this example i create ec2 only in public subnet
  public_subnets       = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k)]
  # for production you should create ec2 in private subnet and use alb/nlb to access it
  private_subnets      = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 4)]
  enable_dns_hostnames = true
  enable_dns_support   = true
  create_igw           = true
  enable_nat_gateway   = true
  single_nat_gateway   = true
  tags = local.tags

}
