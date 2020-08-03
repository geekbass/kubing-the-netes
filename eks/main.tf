/**
* # Running an EKS with Terraform >= .12
* Please refer official [EKS documentation](https://docs.aws.amazon.com/eks/latest/userguide/what-is-eks.html) for more information about EKS.
* 
* NOTE: For a small cluster it will take anywhere from 10-15 minutes to complete initial creation.
* 
* Please refer to official [Terrform EKS](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_cluster) docs for more information about the Terraform code.
* 
* Example:
*
* ```hcl
* module "eks" {
*     source = "./terraform"
*     cluster_name   = "my-eks-001
*     kubernetes_version = "1.17"
* 
*     # Workers
*     desired_number_workers = 2
*     min_number_workers     = 2
*     max_number_workers     = 2
*     instance_types         = "m5.2xlarge"
*     }
* ```
*/

provider "aws" {
  version = ">= 2.58"
}

data "aws_region" "current" {}

provider "random" {
  version = ">= 2.0"
}

module "eks" {
  source             = "./terraform"
  cluster_name       = var.cluster_name
  kubernetes_version = var.kubernetes_version
  aws_profile        = var.aws_profile

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