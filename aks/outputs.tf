locals {
  kubeconfig = <<KUBECONFIG
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: ${azurerm_kubernetes_cluster.aks.kube_config.0.cluster_ca_certificate}
    server: ${azurerm_kubernetes_cluster.aks.kube_config.0.host}
  name: ${local.cluster_name}
contexts:
- context:
    cluster: ${local.cluster_name}
    user: kubernetes-admin
  name: kubernetes-admin@${local.cluster_name}
current-context: kubernetes-admin@${local.cluster_name}
kind: Config
preferences: {}
users:
- name: kubernetes-admin
  user:
    client-certificate-data: ${azurerm_kubernetes_cluster.aks.kube_config.0.client_certificate}
    client-key-data: ${azurerm_kubernetes_cluster.aks.kube_config.0.client_key}
KUBECONFIG
}

output "kubeconfig" {
  value = local.kubeconfig
}
