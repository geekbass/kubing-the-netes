data "google_client_config" "current" {}

provider "kubernetes" {
  version                = "~> 1.11"
  load_config_file       = false
  host                   = "https://${google_container_cluster.primary.endpoint}"
  token                  = data.google_client_config.current.access_token
  cluster_ca_certificate = base64decode(google_container_cluster.primary.master_auth.0.cluster_ca_certificate)
}

resource "kubernetes_cluster_role_binding" "gke-client-binding" {
  metadata {
    name = "gke-client-binding"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }
  subject {
    kind = "User"
    name = "client"
  }
}