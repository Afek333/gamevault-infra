########################################################
# EKS Cluster (terraform-aws-modules/eks)
########################################################
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.8"

  cluster_name    = "${var.project_name}-cluster"
  cluster_version = "1.29"

  cluster_endpoint_public_access = true

  vpc_id                   = module.vpc.vpc_id
  subnet_ids               = module.vpc.private_subnets
  control_plane_subnet_ids = module.vpc.private_subnets

  enable_irsa = true  # OIDC for service accounts (useful later for AWS auth)

  # Managed node group (worker nodes)
  eks_managed_node_groups = {
    default = {
      ami_type       = "AL2_x86_64"
      instance_types = ["t3.medium"]
      desired_size   = 2
      min_size       = 2
      max_size       = 3
    }
  }

  tags = {
    Project = var.project_name
  }
}

output "cluster_name" {
  value = module.eks.cluster_name
}
output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}
output "cluster_version" {
  value = module.eks.cluster_version
}
output "oidc_provider_arn" {
  value = module.eks.oidc_provider_arn
}
