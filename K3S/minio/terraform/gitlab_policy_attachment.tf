resource "minio_iam_user_policy_attachment" "gitlab_user_policy_attachment" {
  user_name   = minio_iam_user.gitlab_iam_user.id
  policy_name = minio_iam_policy.gitlab_iam_policy.id
}

output "gitlab_user_policy_attachment_name" {
  value = minio_iam_user_policy_attachment.gitlab_user_policy_attachment.id
}
