output "eks_cluster_id" {
  description = "The name of the cluster"
  value       = module.eks.eks_cluster_id
}

output "eks_cluster_arn" {
  description = "The Amazon Resource Name (ARN) of the cluster"
  value       = module.eks.eks_cluster_arn
}

output "config_map_aws_auth" {
  value = module.eks.config_map_aws_auth
}

output "kubeconfig" {
  description = "Kubeconfig for Kuberenetes API"
  value       = module.eks.kubeconfig
}
