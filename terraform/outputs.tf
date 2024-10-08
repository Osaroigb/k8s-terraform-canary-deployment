output "cluster_endpoint" {
  description = "The endpoint for the EKS control plane"
  value       = aws_eks_cluster.eks_cluster.endpoint
}

output "cluster_name" {
  description = "The name of the EKS cluster"
  value       = aws_eks_cluster.eks_cluster.name
}

output "worker_iam_role" {
  description = "IAM role assigned to EKS worker nodes"
  value       = aws_iam_role.worker_role.arn
}

output "private_subnets" {
  description = "IDs of private subnets"
  value       = module.vpc.private_subnets
}

output "public_subnets" {
  description = "IDs of public subnets"
  value       = module.vpc.public_subnets
}

output "public_ip" {
  description = "The public IP detected using ipify.org"
  value       = data.http.my_ip.response_body
}