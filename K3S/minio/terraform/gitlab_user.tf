resource "minio_iam_user" "gitlab_iam_user" {
  name          = "gitlab"
  force_destroy = true
}

output "gitlab_user_id" {
  value = minio_iam_user.gitlab_iam_user.id
}

output "gitlab_user_status" {
  value = minio_iam_user.gitlab_iam_user.status
}

output "gitlab_user_secret" {
  value = minio_iam_user.gitlab_iam_user.secret
  sensitive = true
}
