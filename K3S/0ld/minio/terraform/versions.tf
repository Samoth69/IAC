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

provider "minio" {
  # configuration in env vars
  minio_ssl = true
}

provider "kubernetes" {
  # Configuration options
  config_path    = "~/.kube/config"
  config_context = "default"
}