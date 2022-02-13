terraform {
  backend "s3" {
    bucket = "state-tf-aws-us-east1"
    key    = ".terraform/"
    region = "us-east-1"
  }
}
