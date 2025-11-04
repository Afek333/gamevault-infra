resource "aws_eks_access_entry" "afek_admin" {
  cluster_name  = module.eks.cluster_name
  principal_arn = "arn:aws:iam::888577066420:user/afek-tf-admin"
  type          = "STANDARD"
}

resource "aws_eks_access_policy_association" "afek_admin_policy" {
  cluster_name  = module.eks.cluster_name
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
  principal_arn = aws_eks_access_entry.afek_admin.principal_arn
  access_scope {
    type = "cluster"
  }
}
