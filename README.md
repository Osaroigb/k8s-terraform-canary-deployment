# k8s-terraform-canary-deployment
Kubernetes Canary Deployment on AWS using Terraform and GitHub Actions. This project involves creating a Kubernetes cluster on AWS free tier using Terraform, deploying a Node.js Express application with load balancing and canary deployment, and automating the deployment process using GitHub Actions.


## Setup EKS with Terraform
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
```


## Apply Kubernetes Configurations
1. Deploy the main service:
   ```bash
   aws eks --region us-east-1 update-kubeconfig --name whoami-cluster
   kubectl get nodes
   kubectl get services

   kubectl apply -f kubernetes/deployment.yaml
   kubectl apply -f kubernetes/service.yaml
   ```

2. Apply the canary deployment:
   ```bash
   kubectl apply -f kubernetes/canary-deployment.yaml
   kubectl apply -f kubernetes/canary-service.yaml
   ```

3. Check if the pods are running:
   ```bash
   kubectl get pods
   kubectl get services
   ```


## Test Load Balancing
- Since Kubernetes LoadBalancer Service automatically exposes the service to an external IP, accessing the IP will demonstrate load balancing between the pods.

- Use `curl` to access the load balancer IP multiple times and verify that responses are coming from different replicas.

```bash
curl http://<LoadBalancer-IP>
```


## Test Canary Deployment
- Access the canary service using the load balancer IP of the canary service:
```bash
curl http://<Canary-LoadBalancer-IP>
```
