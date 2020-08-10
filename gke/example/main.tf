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
  source       = "../terraform"
  cluster_name = "gke-cluster-001"
  region       = "us-west1"
  labels = {
    owner      = "weston"
    expiration = "24h"
  }

  # Workers
  node_count        = 4
  nodes_preemptible = true

  providers = {
    google = google
  }
}