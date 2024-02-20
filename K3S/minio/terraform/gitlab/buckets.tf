resource "minio_s3_bucket" "buckets" {
  for_each = toset(["registry", "artifacts", "uploads", "backup", "backup-tmp"])
  bucket   = "gitlab-${each.key}"
  acl      = "private"
}
