resource "minio_s3_bucket" "buckets" {
  bucket   = "harbor-registry"
  acl      = "private"
}
