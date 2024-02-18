resource "minio_s3_bucket" "gitlab_buckets" {
  for_each = toset(["artifacts", "uploads", "backup", "backup-tmp"])
  bucket   = "gitlab-${each.key}"
  acl      = "private"
}
