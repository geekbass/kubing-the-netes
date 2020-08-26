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
*    source = "./terraform"
*  
*    cluster_name       = "my-aks-001"
*    kubernetes_version = "1.17.9"
*    location           = var.location
*    tags               = var.tags
*  
*    # Worker Nodes
*    vm_size                   = var.vm_size
*    availability_zones        = var.availability_zones
*    node_count                = var.node_count
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

module "aks" {
  source = "./terraform"

  cluster_name       = var.cluster_name
  kubernetes_version = var.kubernetes_version
  location           = var.location
  tags               = var.tags

  # Worker Nodes
  vm_size = var.vm_size
  //availability_zones        = var.availability_zones
  node_count                = var.node_count
  role_based_access_control = var.role_based_access_control
  kube_dashboard            = var.kube_dashboard

  providers = {
    azurerm = azurerm
  }
}

