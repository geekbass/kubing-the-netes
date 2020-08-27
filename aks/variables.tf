variable "cluster_name" {
  description = "The name of your AKS Cluster."
  default     = "my-aks"
}

variable "kubernetes_version" {
  description = "Desired Kubernetes Version for the Cluster. This is used for Both Control Plane and Workers."
  default     = "1.17.9"
}

variable "location" {
  description = "Desired Azure Location."
  default     = "westus"
}

variable "vm_size" {
  description = "Size of the VM for Default Node Pool."
  default     = "Standard_DS2_v2"
}

//variable "availability_zones" {
//  description = "Availability Zones in the Region."
//  default     = ""
//}

variable "node_count" {
  description = "Number of Nodes in the Default Node Pool."
  default     = "4"
}

variable "role_based_access_control" {
  description = "Enable RBAC."
  default     = true
}

variable "kube_dashboard" {
  description = "Enable Kubernetes Dashboard."
  default     = false
}

variable "tags" {
  description = "Tags for your cluster and resources."
  type        = map(string)
  default     = {}
}

variable "cluster_name_random_string" {
  description = "Add a random string to the cluster name"
  default     = false
}


