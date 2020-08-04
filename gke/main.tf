/** 
* # Running a GKE with Terraform >= .12
* 
*
* 
*
* 
*
* 
* Example:
*
* ```hcl
* module "gke" {
*  source                 = "./terraform"
*  cluster_name           = "gke-cluster"
*  region                 = "us-west-1"
*  labels = {
*    owner = "dave"
*    type  = "kubernetes"
*   }
*
*  # Workers
*  node_count                   = 6
*  nodes_preemptible            = true
*
*  providers = {
*      google = google
*  }
* }
* ```
*/

provider "google" {
  version = "~> 3.0"
}

provider "null" {
  version = "~> 2.1"
}

provider "template" {
  version = "~> 2.1"
}

module "gke" {
  source                 = "./terraform"
  cluster_name           = var.cluster_name
  region                 = var.region
  gke_min_master_version = var.gke_min_master_version
  tags                   = var.tags

  # Workers
  node_pool_machine_type       = var.node_pool_machine_type
  node_count                   = var.node_count
  node_extra_pool_machine_type = var.node_extra_pool_machine_type
  node_extra_count             = var.node_extra_count
  nodes_preemptible            = var.nodes_preemptible

  providers = {
    google = google
  }
}
