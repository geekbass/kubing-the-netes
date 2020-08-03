# Kubing-the-Netes
A collection of code to simplify and create many different types of Kuberentes clusters (AKS, EKS, GKE, Konvoy, etc...) as well as anything else helpful such as workload, charts, etc...

### AKS

### EKS

### Konvoy

### Contributing
1) Please ensure to test changes. Ensure to include if breaking etc in PR.

2) Ensure to `fmt` your files.
```
terraform fmt
```

3) When adding new variables, outputs, etc... ensure to include them in the README using [`terraform-docs`](https://github.com/terraform-docs/terraform-docs).

```
terraform-docs markdown ./ > README.md
```

See the [User Guide](https://github.com/terraform-docs/terraform-docs/blob/master/docs/USER_GUIDE.md) on formatting etc...

### To Do
- Syncing to Registry?