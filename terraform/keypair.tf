# Create a keypair for EC2 instances
module "ec2-keypair" {
    source = "terraform-aws-modules/key-pair/aws"
    version = "2.0.2"
    key_name = "${local.name}-keypair"
    create_private_key = true
    private_key_algorithm = "ED25519"
    tags = local.tags
}   

# export private key to ssm parameter ( for emergency access)
resource "aws_ssm_parameter" "key" {
  name = "/${local.name}/key"
  type = "SecureString"
  value = module.ec2-keypair.private_key_openssh
}