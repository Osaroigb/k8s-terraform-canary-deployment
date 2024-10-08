# k8s-terraform-canary-deployment

This project demonstrates how to perform **Canary Deployments** on a Kubernetes cluster, provisioned using **Amazon EKS (Elastic Kubernetes Service)** and **Terraform**. We deploy a Node.js Express application (`congtaojiang/whoami-nodejs-express`) with multiple replicas, load balancing, and a canary release using **GitHub Actions** for automated CI/CD.

## Table of Contents
1. [Project Overview](#project-overview)
2. [Pre-requisites](#pre-requisites)
3. [AWS EKS Cluster Setup using Terraform](#aws-eks-cluster-setup-using-terraform)
4. [Kubernetes Deployment](#kubernetes-deployment)
5. [Testing Load Balancing](#testing-load-balancing)
6. [Canary Deployment](#canary-deployment)
7. [Automation using GitHub Actions](#automation-using-github-actions)

## Project Overview
The project utilizes **Terraform** to provision an EKS cluster on AWS, where two versions of the same service (a main service and a canary) are deployed using **Kubernetes**. A load balancer distributes traffic across the replicas of the services, and the canary release allows you to test new versions with a portion of the traffic before fully rolling out.

## Pre-requisites
To set up and deploy this project, ensure you have the following installed on your local machine:
- **AWS CLI**: To interact with AWS services.
- **kubectl**: For managing Kubernetes clusters.
- **Terraform**: For infrastructure as code.
- **AWS IAM permissions**: Ensure you have the necessary IAM roles set up with access to EKS and EC2 resources.

### Installations:
```bash
# AWS CLI Installation
brew install awscli  # macOS
sudo apt-get install awscli  # Ubuntu

# Terraform Installation
brew tap hashicorp/tap
brew install hashicorp/tap/terraform

# kubectl Installation
brew install kubectl
```

## AWS EKS Cluster Setup using Terraform

1. **Configure AWS CLI**: Make sure your AWS CLI is properly configured:
   ```bash
   aws configure
   ```

2. **Set up S3 Bucket for Terraform State**: 
   Create an S3 bucket to store the Terraform state file. This bucket ensures that the state is stored remotely and shared between team members, enabling collaboration.

   Create an S3 bucket named `terraform-state-whoami` and create a `terraform` object within the bucket

3. **Initialize Terraform**: 
   ```bash
   terraform init
   ```

4. **Validate the Terraform configuration**: Ensure that your configuration files are syntactically valid.

   ```bash
   terraform validate
   ```

5. **Format Terraform code**: Format the configuration to ensure consistent syntax and styling.

   ```bash
   terraform fmt
   ```

6. **Plan the Infrastructure**: Review the resources that will be created.
   ```bash
   terraform plan
   ```

7. **Apply the Terraform Plan**: This command provisions the EKS cluster and associated resources.
   ```bash
   terraform apply
   ```

8. **Destroy the Infrastructure**: To tear down the infrastructure.
   ```bash
   terraform destroy
   ```

**Note**: This will create the necessary EKS cluster and networking (VPC, Subnets, Security Groups), and IAM roles needed for Kubernetes on AWS.

## Kubernetes Deployment

### 1. Apply Main Service Deployment
Once your EKS cluster is running, deploy the main service using the provided Kubernetes manifest files.

```bash
kubectl apply -f kubernetes/deployment.yaml
kubectl apply -f kubernetes/service.yaml
```

The `deployment.yaml` defines a Kubernetes Deployment of 3 replicas, and the `service.yaml` creates a LoadBalancer service that exposes your app to the internet.

### 2. Apply Canary Deployment
To test a canary release, apply the canary-specific deployment.

```bash
kubectl apply -f kubernetes/canary-deployment.yaml
kubectl apply -f kubernetes/canary-service.yaml
```

This canary deployment allows a new version of the application to be tested with a small portion of traffic.

### 3. Verify Running Services
Ensure that the deployments and services are running as expected:

```bash
kubectl get pods
kubectl get nodes
kubectl get services
kubectl get deployments

kubectl logs <pod_name>
kubectl describe pod <pod_name>
```

## Testing Load Balancing

Kubernetes automatically creates a LoadBalancer with an external IP address. You can test the load balancing feature by sending multiple requests to the service's external IP. Each response should indicate which replica handled the request, demonstrating load balancing.

```bash
curl http://<LoadBalancer-IP>
```

Run the command multiple times to see different instances handling the requests.

## Canary Deployment

To test the canary deployment, access the canary version of the application by querying the canary service’s LoadBalancer IP.

```bash
curl http://<Canary-LoadBalancer-IP>
```

This helps you test the new version of your app while still serving traffic to the stable version. Monitor both services and decide when to fully roll out the canary version.

## Automation using GitHub Actions

This repository is configured with a **GitHub Actions** workflow for continuous integration and deployment. The workflow file (`.github/workflows/deploy.yml`) triggers deployments to the EKS cluster upon changes to the main branch.

### GitHub Actions Workflow

The workflow:
1. Checks out the repository.
2. Sets up Kubernetes and AWS credentials.
3. Applies the Kubernetes manifests (both for the main service and the canary deployment).

Ensure that the following secrets are configured in your GitHub repository:
- `AWS_REGION`
- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`
- `AWS_EKS_CLUSTER_NAME`
- `USER_EMAIL` (your GitHub email)
- `USER_NAME` (your GitHub username)


### Cleanup Step
Once the deployments are complete and tested, you may want to clean up the cluster by removing all running pods, services, and deployments to avoid resource usage:

```bash
kubectl delete pods --all
kubectl delete services --all
kubectl delete deployments --all
```

This will ensure that no resources are left running, freeing up the environment.

## Conclusion

This project demonstrates how to set up an EKS cluster using Terraform, deploy a service with Kubernetes, perform canary releases, and automate deployments using GitHub Actions. By leveraging these tools, you can easily manage, test, and scale your services in a cloud-native environment.

For more information, refer to:
- [AWS EKS Documentation](https://docs.aws.amazon.com/eks/)
- [Terraform AWS EKS Module](https://registry.terraform.io/modules/terraform-aws-modules/eks/aws/latest)
- [Kubernetes Canary Deployment](https://kubernetes.io/docs/concepts/cluster-administration/manage-deployment/)