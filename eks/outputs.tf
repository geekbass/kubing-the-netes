output "config_map_aws_auth" {
    value = module.eks.config_map_aws_auth
}

output "kubeconfig" {
    value = module.eks.kubeconfig
}
