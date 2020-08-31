# Kubing-the-Netes
A collection of code to simplify and create many different types of Kuberentes clusters (AKS, EKS, GKE, Konvoy, etc...) as well as anything else helpful such as workload, charts, etc...

Each type will contain an `example` directory that will include working examples that can used and modified. 

If Terraform Registry is being used, the code is written in this repository and is synced via gitsubmodule. It is messy but is done this way in order to keep all the code under a single organized repository instead of scattered.

### Terraform Registry Repos
[AKS Repo](https://github.com/geekbass/terraform-azurerm-aks)

[EKS Repo](https://github.com/geekbass/terraform-aws-eks)

[GKE Repo](https://github.com/geekbass/terraform-google-gke)

## Contributing
***NOTE: To be automated in the future.***

1) Please ensure to test changes. Ensure to include if breaking change etc in PR.

2) Ensure to `fmt` your files.
```
terraform fmt
```

3) When adding new variables, outputs, etc... ensure to include them in the README using [`terraform-docs`](https://github.com/terraform-docs/terraform-docs).

```
terraform-docs markdown ./ > README.md
```

See the [User Guide](https://github.com/terraform-docs/terraform-docs/blob/master/docs/USER_GUIDE.md) on formatting etc...

### New Version for Terraform Registry
1) Go to according repo that is synced to the Registry.

2) Run the Makefile specifying the branch.
```
make update BRANCH=master
```
3) Commit and merge the changes.

4) Cut the new Release. Specify in version format 0.0.X with version in title and meaningful description.

5) Go to the Registry and sync the changes.
