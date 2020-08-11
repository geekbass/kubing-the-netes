/** 
* # Running a GKE with Terraform >= .12
* Please refer to official [GKE Docs](https://cloud.google.com/kubernetes-engine/docs).
*
* 
* Please refer to specific [Terraform GKE](https://www.terraform.io/docs/providers/google/guides/using_gke_with_terraform.html) Docs.
* 
* This is a Regional Cluster setup with a new network.
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
* ### Prerequisites
* - [Terraform](https://www.terraform.io/downloads.html) 12 or later
* - [GCLoud CLI](https://cloud.google.com/sdk/gcloud)
*/

provider "google" {
  version = "~> 3.0"
}

provider "random" {
  version = ">= 2.0"
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
