/**
* # Running an AKS with Terraform >= .12
* Please refer official [AKS documentation]() for more information about EKS.
* 
* NOTE: For a small cluster it will take anywhere from 10-15 minutes to complete initial creation.
* 
* Please refer to official [Terrform AKS]() docs for more information about the Terraform code.
* 
* Example:
*
* ```hcl
* module "aks" {
*    source = "geekbass/terraform-azurerm-aks"
*    version = "~> 0.0.1"
*  
*    cluster_name       = "my-aks-001"
*    kubernetes_version = "1.17.9"
*    location           = "uswest"
*    tags      {
*       name = "my-aks-001"
*       env  = "prod"
*       }
*
*    # Worker Nodes
*    node_count = 5
*  }
* ```
* ### Prerequisites
* - [Terraform](https://www.terraform.io/downloads.html) 12 or later
* - [Azure CLI]()
*/

provider "azurerm" {
  version = ">= 2.20"
  features {}
}

provider "random" {
  version = ">= 2.0"
}

resource "random_id" "id" {
  byte_length = 4
  prefix      = var.cluster_name
}

locals {
  cluster_name = var.cluster_name_random_string ? random_id.id.hex : var.cluster_name
}

resource "azurerm_resource_group" "aks" {
  name     = "${local.cluster_name}-rg"
  location = var.location
}

resource "azurerm_kubernetes_cluster" "aks" {

  depends_on = [
    azurerm_resource_group.aks
  ]

  name                = local.cluster_name
  resource_group_name = azurerm_resource_group.aks.name
  location            = azurerm_resource_group.aks.location
  dns_prefix          = "${local.cluster_name}-dns"
  kubernetes_version  = var.kubernetes_version #coalesece 

  //api_server_authorized_ip_ranges = [var.api_server_authorized_ip_ranges]

  default_node_pool {
    name    = "main"
    vm_size = var.vm_size
    //availability_zones   = var.availability_zones
    //vnet_subnet_id       = local.subnet_id
    enable_auto_scaling  = false
    node_count           = var.node_count
    orchestrator_version = var.kubernetes_version
  }

  identity {
    type = "SystemAssigned"
  }

  //service_principal {
  //  client_id     = var.service_principal_id     # If exist
  //  client_secret = var.service_principal_secret # if exist 
  //}

  role_based_access_control {
    enabled = var.role_based_access_control
  }

  network_profile {
    network_plugin = "kubenet"
    // Accept the defaults for now
    //service_cidr       = var.service_cidr
    //dns_service_ip     = var.dns_service_ip
    //pod_cidr           = var.pod_cidr
    //docker_bridge_cidr = var.docker_bridge_cidr
  }
  addon_profile {
    kube_dashboard {
      enabled = var.kube_dashboard
    }
  }

  tags = var.tags
}
