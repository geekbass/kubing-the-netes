# AKS How To

### ASK Deploy Cluster

1) Login to Azure portal via Azure CLI
```
az login
```
2) List your accounts and decide which one you would like to use and set it. Hint: This is the `id` field associated of your subscription. See more information on official [Terafform Docs](https://www.terraform.io/docs/providers/azurerm/guides/azure_cli.html).
```
az account list
az account set --subscription="$SUBSCRIPTION_ID"
```

3) Copy the `main.tf` and copy it locally making changes necessary.

4) Initialize.
```
terraform init
```

5) Deploy the cluster.
```
terraform plan -out plan.out
terraform apply plan.out
```

### Using with Kubectl
A `kubeconfig.conf` will be created locally that be used to authenticate against the cluster.

```
export KUBECONFIG=kubeconfig.conf

kubectl get cluster-info

```

### AKS Destroy
```
terraform destroy
```