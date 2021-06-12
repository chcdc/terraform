data "aws_s3_bucket_object" "ssh-key" {
  bucket = "secrets-aws"
  key    = "ssh-key.pem"
}
