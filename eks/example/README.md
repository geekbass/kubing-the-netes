# EKS How To

### EKS Deploy Cluster
1) Take the `./main.tf` and copy it locally.

2) Make changes to the variables as you see fit.

3) Auth to AWS.

4) Run apply.
```
terraform plan -out plan.out
terraform apply plan.out
```
### EKS Destroy
1) Run destroy.
```
terraform destroy
```