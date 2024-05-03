resource "minio_iam_policy" "iam_policy" {
  name   = "gitlab-iam-policy"
  policy = file("${path.module}/policy.json")
}

output "iam_policy_id" {
  value = minio_iam_policy.iam_policy.id
}
