resource "minio_iam_user" "iam_user" {
  name          = "gitlab"
  force_destroy = true
}

output "user_id" {
  value = minio_iam_user.iam_user.id
}

output "user_status" {
  value = minio_iam_user.iam_user.status
}

output "user_secret" {
  value = minio_iam_user.iam_user.secret
  sensitive = true
}
