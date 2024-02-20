resource "kubernetes_secret" "kube_secret" {
  metadata {
    namespace = "harbor"
    name      = "harbor-object-storage"
  }

  type = "opaque"
  data = {
    REGISTRY_STORAGE_S3_ACCESSKEY = minio_iam_user.iam_user.id
    REGISTRY_STORAGE_S3_SECRETKEY = minio_iam_user.iam_user.secret
  }
}
