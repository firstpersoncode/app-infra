terraform {
  backend "s3" {
    bucket = "dev-proj-1-app-infra-remote-state-bucket-66996699"
    key    = "devops-project-1/terraform.tfstate"
    region = "ap-southeast-2"
  }
}