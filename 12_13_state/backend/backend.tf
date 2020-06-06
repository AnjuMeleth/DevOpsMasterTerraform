terraform {
  backend "s3" {
    # Replace this with your bucket name!
    bucket         = "terraformupandrunningstate"
    key            = "global/s3/terraform.tfstate"
    region         = "ap-south-1"

    encrypt        = true
  }
}
