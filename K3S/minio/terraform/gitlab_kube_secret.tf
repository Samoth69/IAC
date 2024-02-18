resource "kubernetes_secret" "gitlab_kube_secret" {
  metadata {
    namespace = "gitlab"
    name      = "gitlab-object-storage"
  }

  type = "opaque"
  data = {
    connection = yamlencode({
      provider              = "AWS"
      region                = "us-east-1"
      regionendpoint        = "https://minio-api.k3s.samoth.eu"
      aws_access_key_id     = minio_iam_user.gitlab_iam_user.id
      aws_secret_access_key = minio_iam_user.gitlab_iam_user.secret
      v4auth                = true
    })
  }
}

resource "kubernetes_secret" "gitlab_kube_backup_secret" {
  metadata {
    namespace = "gitlab"
    name      = "gitlab-backup-storage"
  }

  type = "generic"
  data = {
    config = templatefile("gitlab_backup_config.tftpl", {
      "access_key" : minio_iam_user.gitlab_iam_user.id,
      "secret_key" : minio_iam_user.gitlab_iam_user.secret,
    })
  }
}
