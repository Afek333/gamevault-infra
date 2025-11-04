terraform {
  backend "s3" {
    bucket         = "gamevault-terraform-state"
    key            = "infra/terraform.tfstate"
    region         = "eu-central-1"
    encrypt        = true
  }
}
