output "kubeconfig" {
  description = "Kubeconfig for Kuberenetes API"
  value       = module.gke.kubeconfig
}
