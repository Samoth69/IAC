resource "minio_s3_bucket" "buckets" {
  bucket   = "rclone-data"
  acl      = "private"
}
