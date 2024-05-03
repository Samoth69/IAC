resource "minio_iam_user_policy_attachment" "user_policy_attachment" {
  user_name   = minio_iam_user.iam_user.id
  policy_name = minio_iam_policy.iam_policy.id
}

output "user_policy_attachment_name" {
  value = minio_iam_user_policy_attachment.user_policy_attachment.id
}
