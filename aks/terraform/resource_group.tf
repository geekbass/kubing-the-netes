resource "azurerm_resource_group" "aks" {
  name     = "${local.cluster_name}-rg"
  location = var.location
}