terraform {
  backend "s3" {
    bucket = "mpadhi-example-bucket-eks-001"
    key    = "terraform.tfstate"
    region = "us-east-2"
  }
}
