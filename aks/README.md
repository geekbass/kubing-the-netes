# Running an AKS with Terraform >= .12  
Please refer official [AKS documentation]() for more information about EKS.

NOTE: For a small cluster it will take anywhere from 10-15 minutes to complete initial creation.

Please refer to official [Terrform AKS]() docs for more information about the Terraform code.

Example:

```hcl
module "aks" {
   source = "./terraform"

   cluster_name       = "my-aks-001"
   kubernetes_version = "1.17.9"
   location           = "uswest"
   tags      {
      name = "my-aks-001"
      env  = "prod"
      }

   # Worker Nodes
   node_count = 5
 }
```
### Prerequisites
- [Terraform](https://www.terraform.io/downloads.html) 12 or later
- [Azure CLI]()

## Requirements

| Name | Version |
|------|---------|
| azurerm | >= 2.20 |
| random | >= 2.0 |

## Providers

No provider.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cluster\_name | The name of your AKS Cluster. | `string` | `"my-aks"` | no |
| kube\_dashboard | Enable Kubernetes Dashboard. | `bool` | `true` | no |
| kubernetes\_version | Desired Kubernetes Version for the Cluster. This is used for Both Control Plane and Workers. | `string` | `"1.17.9"` | no |
| location | Desired Azure Location. | `string` | `"westus"` | no |
| node\_count | Number of Nodes in the Default Node Pool. | `string` | `"4"` | no |
| role\_based\_access\_control | Enable RBAC. | `bool` | `true` | no |
| tags | Tags for your cluster and resources. | `map(string)` | `{}` | no |
| vm\_size | Size of the VM for Default Node Pool. | `string` | `"Standard_DS2_v2"` | no |

## Outputs

| Name | Description |
|------|-------------|
| kubeconfig | n/a |

