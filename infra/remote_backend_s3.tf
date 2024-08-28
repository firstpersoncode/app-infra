terraform {
  backend "s3" {
    bucket = "dev-proj-1-remote-state-bucket-123456"
    key    = "devops-project-1/terraform.tfstate"
    region = "ap-southeast-1"
  }
}