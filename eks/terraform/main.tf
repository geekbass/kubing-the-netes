provider "aws" {
  version = ">= 2.58"
}

provider "random" {
  version = ">= 2.0"
}

data "aws_region" "current" {}

resource "random_id" "id" {
  byte_length = 4
  prefix      = var.cluster_name
}

locals {
  cluster_name = var.cluster_name_random_string ? random_id.id.hex : var.cluster_name
}