provider "aws" {
    version = ">= 2.58"
}

data "aws_region" "current" {}

provider "random" {
  version = ">= 2.0"
}

module "eks" {
    source = "./terraform"
    cluster_name   = var.cluster_name
    kubernetes_version = var.kubernetes_version

    # Workers
    node_group_name        = var.node_group_name
    desired_number_workers = var.desired_number_workers
    min_number_workers     = var.min_number_workers
    max_number_workers     = var.max_number_workers
    ami_type               = var.ami_type
    disk_size              = var.disk_size
    force_update_version   = var.force_update_version
    instance_types         = var.instance_types

    providers = {
    aws = aws
  }
}