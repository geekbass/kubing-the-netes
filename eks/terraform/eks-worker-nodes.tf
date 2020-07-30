resource "aws_eks_node_group" "eks" {
  cluster_name    = aws_eks_cluster.eks.name
  node_group_name = var.node_group_name
  node_role_arn   = aws_iam_role.eks-node.arn
  subnet_ids      = aws_subnet.eks[*].id

  ami_type             = var.ami_type
  disk_size            = var.disk_size
  force_update_version = var.force_update_version
  instance_types       = [var.instance_types]

  scaling_config {
    desired_size = var.desired_number_workers
    max_size     = var.max_number_workers
    min_size     = var.min_number_workers
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks-node-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.eks-node-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.eks-node-AmazonEC2ContainerRegistryReadOnly,
  ]
}