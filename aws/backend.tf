terraform {
  backend "s3" {
    bucket = "state-tf-aws-useast1"
    key    = ".terraform/"
    region = "us-east-1"
  }
}
