module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
    
  name = "${var.project}-${terraform.workspace}"
  cidr = var.vpc_cidr

  azs             = var.azs
  public_subnets  = var.public_subnets_cidr
  private_subnets = var.private_subnets_cidr
  database_subnets = var.database_subnets_cidr
  create_database_subnet_group           = true

  enable_nat_gateway = true
  single_nat_gateway  = true

  enable_vpn_gateway = false

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Terraform = "true"
    Environment = terraform.workspace
    Project = var.project
  }
}