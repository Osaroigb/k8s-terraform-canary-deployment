variable "aws_region" {
  description = "AWS Region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "cluster_name" {
  description = "Name of the EKS Cluster"
  type        = string
  default     = "whoami-cluster"
}

variable "MYIP" {
  default = "102.67.9.207/32"
}

variable "VPC_NAME" {
  default = "whoami-VPC"
}

# variable "Zone1" {
#   default = "us-east-1a"
# }

# variable "Zone2" {
#   default = "us-east-1b"
# }

# variable "Zone3" {
#   default = "us-east-1c"
# }

variable "VpcCIDR" {
  description = "VPC CIDR block"
  type        = string
  default     = "172.21.0.0/16"
}


# variable "PubSub1CIDR" {
#   default = "172.21.1.0/24"
# }

# variable "PubSub2CIDR" {
#   default = "172.21.2.0/24"
# }

# variable "PubSub3CIDR" {
#   default = "172.21.3.0/24"
# }

# variable "PrivSub1CIDR" {
#   default = "172.21.4.0/24"
# }

# variable "PrivSub2CIDR" {
#   default = "172.21.5.0/24"
# }

# variable "PrivSub3CIDR" {
#   default = "172.21.6.0/24"
# }

variable "private_subnets" {
  description = "Private subnet CIDRs"
  type        = list(string)
  default     = ["172.21.4.0/24", "172.21.5.0/24", "172.21.6.0/24"]
}

variable "public_subnets" {
  description = "Public subnet CIDRs"
  type        = list(string)
  default     = ["172.21.1.0/24", "172.21.2.0/24", "172.21.3.0/24"]
}

variable "subnet_zones" {
  description = "Subnet zones"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}