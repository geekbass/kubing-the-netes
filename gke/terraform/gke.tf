resource "google_container_cluster" "primary" {
  name                     = local.cluster_name
  location                 = var.region
  network                  = google_compute_network.gke.self_link
  subnetwork               = google_compute_subnetwork.gke.self_link
  remove_default_node_pool = var.node_count == 0 ? true : false
  initial_node_count       = var.node_count == 0 ? 1 : var.node_count

  min_master_version = var.gke_min_master_version

  ip_allocation_policy {
    cluster_secondary_range_name  = "cluster"
    services_secondary_range_name = "services"
  }

  master_auth {
    username = ""
    password = ""

    client_certificate_config {
      issue_client_certificate = true
    }
  }

  maintenance_policy {
    recurring_window {
      start_time = timeadd(timestamp(), "24h")
      end_time   = timeadd(timestamp(), "36h")
      recurrence = "FREQ=WEEKLY;BYDAY=MO,TU,WE,TH,FR"
    }
  }

  node_config {
    preemptible = var.nodes_preemptible
    # see https://cloud.google.com/compute/docs/machine-types
    machine_type = var.node_pool_machine_type

    metadata = {
      disable-legacy-endpoints = "true"
    }

    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    labels = merge(
      var.labels,
      {
        "name"    = local.cluster_name,
        "cluster" = local.cluster_name,
      }
    )
  }

  resource_labels = merge(
    var.labels,
    {
      "name"    = local.cluster_name,
      "cluster" = local.cluster_name,
    }
  )
}

resource "google_container_node_pool" "extra_nodes" {
  name       = "${local.cluster_name}-node-pool"
  location   = var.region
  cluster    = google_container_cluster.primary.name
  node_count = var.node_extra_count

  management {
    auto_repair  = false
    auto_upgrade = false
  }

  node_config {
    preemptible = var.nodes_preemptible
    # see https://cloud.google.com/compute/docs/machine-types
    machine_type = var.node_extra_pool_machine_type

    metadata = {
      disable-legacy-endpoints = "true"
    }

    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    labels = merge(
      var.labels,
      {
        "name"    = local.cluster_name,
        "cluster" = local.cluster_name,
      }
    )
  }
}