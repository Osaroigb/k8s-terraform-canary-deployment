terraform {
  backend "s3" {
    bucket = "terraform-state-whoami"
    key    = "terraform/backend"
    region = "us-east-1"
  }
}