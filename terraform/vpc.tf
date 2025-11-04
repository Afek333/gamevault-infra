########################################################
# VPC for EKS (terraform-aws-modules/vpc)
########################################################
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = "${var.project_name}-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["eu-central-1a", "eu-central-1b"]
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets = ["10.0.3.0/24", "10.0.4.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true

  public_subnet_tags = {
    "kubernetes.io/role/elb" = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = "1"
  }

  tags = {
    Project = var.project_name
  }
}

output "vpc_id" {
  value = module.vpc.vpc_id
}
output "private_subnets" {
  value = module.vpc.private_subnets
}
output "public_subnets" {
  value = module.vpc.public_subnets
}
