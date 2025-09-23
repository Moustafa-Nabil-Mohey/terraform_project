#################################
# S3 Bucket (Unique Name)
#################################
resource "aws_s3_bucket" "Cloudkode_s3" {
  bucket        = "cloudkode-s3-${random_id.bucket_suffix.hex}"  # Solves duplication errors.
  #→ Added random_id to make the bucket name unique each time (e.g., cloudkode-s3-a12f4c9b).
  force_destroy = true      #→ Allows bucket to be deleted even if it contains objects.       
  tags = { 
    Name = "CloudkodeS3Bucket"
  }
}

resource "random_id" "bucket_suffix" {#→ Generates a random suffix for the bucket name.
  byte_length = 4
}
