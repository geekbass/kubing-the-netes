data "template_file" "kubeconfig" {
  template = <<EOF
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: $${certificate_authority_data}
    server: https://$${server}:443
  name: gke-$${cluster_name}
contexts:
- context:
    cluster: gke-$${cluster_name}
    user: kubernetes-admin
  name: kubernetes-admin@gke-$${cluster_name}
current-context: kubernetes-admin@gke-$${cluster_name}
kind: Config
preferences: {}
users:
- name: kubernetes-admin
  user:
    client-certificate-data: $${client_certificate_data}
    client-key-data: $${client_key_data}
EOF

  vars = {
    certificate_authority_data = google_container_cluster.primary.master_auth.0.cluster_ca_certificate
    server                     = google_container_cluster.primary.endpoint
    cluster_name               = local.cluster_name
    client_certificate_data    = google_container_cluster.primary.master_auth.0.client_certificate
    client_key_data            = google_container_cluster.primary.master_auth.0.client_key
  }
}

resource "null_resource" "local_file_write_kubeconfig" {
  triggers = {
    template = data.template_file.kubeconfig.rendered
  }

  provisioner "local-exec" {
    command = "echo \"${chomp(data.template_file.kubeconfig.rendered)}\" > ./kubeconfig.conf"
  }
}