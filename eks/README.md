# EKS
Running an EKS with Terraform >= .12

Please refer official [EKS documentatio]()n for more information about EKS.

NOTE: For a small cluster it will take anywhere from 10-15 minutes to complete initial creation.

Please refer to official [Terrform EKS]() docs for more information about the Terraform code.

Example:
```
module "eks" {
    source = "./terraform"
    cluster_name   = "my-eks-001
    kubernetes_version = "1.17"

    # Workers
    desired_number_workers = 2
    min_number_workers     = 2
    max_number_workers     = 2
    instance_types         = "m5.2xlarge"
}
```

Please see the `./example` directory for a working `main.tf` example that you can use and modify.

### To Do List
 - Add TF variables to README
 - output the kubconfig to local file
 - Add Ability to define multiple Node Groups
 - Custom IAM Roles
 - Custom CIDR Blocks for API
 - Custom Tags
