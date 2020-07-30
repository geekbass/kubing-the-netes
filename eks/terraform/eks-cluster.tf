resource "aws_eks_cluster" "eks" {
  name     = "${local.cluster_name}-eks-cluster"
  role_arn = aws_iam_role.eks-cluster.arn
  version  = var.kubernetes_version

  vpc_config {
    security_group_ids = [aws_security_group.eks-cluster.id]
    subnet_ids         = aws_subnet.eks[*].id
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks-cluster-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.eks-cluster-AmazonEKSServicePolicy,
  ]
}