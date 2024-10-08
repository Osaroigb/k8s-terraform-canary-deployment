# k8s-terraform-canary-deployment
Kubernetes Canary Deployment on AWS using Terraform and GitHub Actions. This project involves creating a Kubernetes cluster on AWS free tier using Terraform, deploying a Node.js Express application with load balancing and canary deployment, and automating the deployment process using GitHub Actions.

```
terraform -version
terraform init

ls -a
ls .terraform/providers

terraform validate
terraform fmt

terraform plan
terraform apply
terraform destroy

aws eks --region us-east-1 update-kubeconfig --name whoami-cluster
kubectl get nodes
kubectl get services
```