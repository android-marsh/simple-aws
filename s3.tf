provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "zip_uploads" {
  bucket = "accurics-zipuploads-one"
  acl    = "private"
  force_destroy = true
}

resource "aws_s3_bucket" "zip_uploads2" {
  bucket = "accurics-zipuploads-two"
  acl    = "private"
  force_destroy = true
}
