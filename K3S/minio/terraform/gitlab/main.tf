terraform {
  required_providers {
    minio = {
      source  = "aminueza/minio"
      version = "2.0.1"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.26.0"
    }
  }
}