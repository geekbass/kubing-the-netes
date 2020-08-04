provider "google" {
  version = "~> 3.0"
}

provider "null" {
  version = "~> 2.1"
}

provider "template" {
  version = "~> 2.1"
}

resource "random_id" "id" {
  byte_length = 4
  prefix      = var.cluster_name
}

locals {
  cluster_name = var.cluster_name_random_string ? random_id.id.hex : var.cluster_name
}