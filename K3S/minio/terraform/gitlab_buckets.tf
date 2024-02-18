resource "minio_s3_bucket" "gitlab_buckets" {
  for_each = toset(["registry", "lfs", "artifacts", "uploads", "packages", "backup"])
  bucket   = "gitlab-${each.key}"
  acl      = "private"
}
