data "http" "my_ip" {
  url = "https://api.ipify.org"
}

data "aws_eks_cluster_auth" "auth" {
  name = aws_eks_cluster.eks_cluster.name
}