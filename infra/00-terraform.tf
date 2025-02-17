terraform {
  backend "s3" {
    bucket  = "tf-state-donsan-personal-web"
    key     = "terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}
