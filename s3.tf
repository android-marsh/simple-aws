provider "aws" {
  region = "us-east-2"
}

resource "aws_s3_bucket" "zip_uploads" {
  bucket        = "accurics-zipuploads-one"
  acl           = "private"
  force_destroy = true

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  versioning {
    enabled = true
  }
}

resource "aws_s3_bucket" "zip_uploads2" {
  bucket        = "accurics-zipuploads-two"
  acl           = "private"
  force_destroy = true

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  versioning {
    enabled = true
  }
}

resource "aws_s3_bucket_policy" "zip_uploads" {
  bucket = "${aws_s3_bucket.zip_uploads.id}"

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "zip_uploads-restrict-access-to-users-or-roles",
      "Effect": "Allow",
      "Principal": [
        {
          "AWS": [
            "arn:aws:iam::##acount_id##:role/##role_name##",
            "arn:aws:iam::##acount_id##:user/##user_name##"
          ]
        }
      ],
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::${aws_s3_bucket.zip_uploads.id}/*"
    }
  ]
}
POLICY
}
resource "aws_s3_bucket_policy" "zip_uploads2" {
  bucket = "${aws_s3_bucket.zip_uploads2.id}"

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "zip_uploads2-restrict-access-to-users-or-roles",
      "Effect": "Allow",
      "Principal": [
        {
          "AWS": [
            "arn:aws:iam::##acount_id##:role/##role_name##",
            "arn:aws:iam::##acount_id##:user/##user_name##"
          ]
        }
      ],
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::${aws_s3_bucket.zip_uploads2.id}/*"
    }
  ]
}
POLICY
}