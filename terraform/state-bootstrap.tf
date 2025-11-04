# S3 bucket עבור Terraform state
resource "aws_s3_bucket" "tf_state" {
  bucket = "${var.project_name}-terraform-state"
  force_destroy = false
}

# הפעלת גרסאות (כדי לשמור היסטוריה של קבצי state)
resource "aws_s3_bucket_versioning" "tf_state_versioning" {
  bucket = aws_s3_bucket.tf_state.id
  versioning_configuration { status = "Enabled" }
}

# הצפנת ה-state
resource "aws_s3_bucket_server_side_encryption_configuration" "tf_state_sse" {
  bucket = aws_s3_bucket.tf_state.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# הגבלת גישה ציבורית
resource "aws_s3_bucket_public_access_block" "tf_state_block" {
  bucket                  = aws_s3_bucket.tf_state.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# טבלת DynamoDB לנעילת state
resource "aws_dynamodb_table" "tf_lock" {
  name         = "${var.project_name}-tf-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

# Outputs כדי לראות את השמות
output "tf_state_bucket" {
  value = aws_s3_bucket.tf_state.id
}

output "tf_lock_table" {
  value = aws_dynamodb_table.tf_lock.name
}
