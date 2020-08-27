provider "azurerm" {
  version = ">= 2.20"
  features {}
}

provider "random" {
  version = ">= 2.0"
}

module "aks" {
  source = "../"

  cluster_name       = "my-aks-001"
  kubernetes_version = "1.17.9"
  location           = "westus2"
  tags = {
    owner      = "weston"
    expiration = "24h"
  }

  # Worker Nodes
  vm_size                   = "Standard_DS2_v2"
  node_count                = 4
  role_based_access_control = true
  kube_dashboard            = false

  providers = {
    azurerm = azurerm
  }
}

// Create kubeconfig local file to be used for kubectl
resource "local_file" "kubeconfig" {
  content  = module.aks.kubeconfig
  filename = "${path.module}/kubeconfig.conf"
}

output "kubeconfig" {
  value = module.aks.kubeconfig
}