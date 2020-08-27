output "kubeconfig" {
  description = "kubeconfig for kubectl"
  value       = azurerm_kubernetes_cluster.aks.kube_config_raw
}