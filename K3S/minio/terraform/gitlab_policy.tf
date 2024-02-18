resource "minio_iam_policy" "gitlab_iam_policy" {
  name   = "gitlab-iam-policy"
  policy = file("gitlab_policy.json")
}

output "gitlab_iam_policy_id" {
  value = minio_iam_policy.gitlab_iam_policy.id
}
