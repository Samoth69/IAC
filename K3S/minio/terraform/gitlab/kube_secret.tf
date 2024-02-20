resource "kubernetes_secret" "kube_secret" {
  metadata {
    namespace = "gitlab"
    name      = "gitlab-object-storage"
  }

  type = "opaque"
  data = {
    connection = yamlencode({
      provider              = "AWS"
      region                = "us-east-1"
      endpoint              = "https://minio-api.k3s.samoth.eu"
      aws_access_key_id     = minio_iam_user.iam_user.id
      aws_secret_access_key = minio_iam_user.iam_user.secret
      path_style            = true
    })
  }
}

resource "kubernetes_secret" "kube_backup_secret" {
  metadata {
    namespace = "gitlab"
    name      = "gitlab-backup-storage"
  }

  type = "generic"
  data = {
    config = templatefile("${path.module}/backup_config.tftpl", {
      "access_key" : minio_iam_user.iam_user.id,
      "secret_key" : minio_iam_user.iam_user.secret,
    })
  }
}

resource "kubernetes_secret" "kube_registry_secret" {
  metadata {
    namespace = "gitlab"
    name      = "gitlab-registry-storage"
  }

  type = "opaque"

  data = {
    connection = yamlencode({
      s3 : {
        bucket         = "gitlab-registry"
        accesskey      = minio_iam_user.iam_user.id
        secretkey      = minio_iam_user.iam_user.secret
        region         = "us-east-1"
        v4auth         = true
        regionendpoint = "https://minio-api.k3s.samoth.eu"
      }
      }
    )
  }
}
