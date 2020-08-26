resource "azurerm_kubernetes_cluster" "aks" {

  depends_on = [
    azurerm_resource_group.aks
  ]

  name                = local.cluster_name
  resource_group_name = azurerm_resource_group.aks.name
  location            = azurerm_resource_group.aks.location
  dns_prefix          = "${local.cluster_name}-dns"
  kubernetes_version  = var.kubernetes_version #coalesece 

  api_server_authorized_ip_ranges = [var.api_server_authorized_ip_ranges]

  default_node_pool {
    name    = "main"
    vm_size = var.vm_size
    //availability_zones   = var.availability_zones
    vnet_subnet_id       = local.subnet_id
    enable_auto_scaling  = false
    node_count           = var.node_count
    orchestrator_version = var.kubernetes_version
  }

  service_principal {
    client_id     = var.service_principal_id     # If exist
    client_secret = var.service_principal_secret # if exist 
  }

  role_based_access_control {
    enabled = var.rbac_enabled
  }

  network_profile {
    network_plugin     = "kubenet"
    service_cidr       = var.service_cidr
    dns_service_ip     = var.dns_service_ip
    pod_cidr           = var.pod_cidr
    docker_bridge_cidr = var.docker_bridge_cidr
  }

  kube_dashboard = var.kube_dashboard

  tags = var.tags
}
