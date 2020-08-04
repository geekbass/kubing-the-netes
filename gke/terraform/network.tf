resource "google_compute_network" "gke" {
  name                            = var.cluster_name
  auto_create_subnetworks         = false
  routing_mode                    = "GLOBAL"
  delete_default_routes_on_create = true
}

resource "google_compute_subnetwork" "gke" {
  name          = var.cluster_name
  ip_cidr_range = "10.32.0.0/24"
  region        = var.region
  network       = google_compute_network.gke.id
  secondary_ip_range {
    range_name    = "cluster"
    ip_cidr_range = "10.0.0.0/16"
  }
  secondary_ip_range {
    range_name    = "services"
    ip_cidr_range = "10.4.0.0/14"
  }
}

resource "google_compute_route" "internet-gateway" {
  name             = "${var.cluster_name}-internet-gateway"
  dest_range       = "0.0.0.0/0"
  network          = google_compute_network.gke.name
  next_hop_gateway = "default-internet-gateway"
  priority         = 100
}