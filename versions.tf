terraform {
  required_version = ">= 1.5.0"
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.30"
    }
  }
}

provider "kubernetes" {
  # When running locally on Mac, it uses ~/.kube/config automatically.
  # When running inside the Atlantis pod on Kubernetes, it automatically
  # uses the in-cluster service account authentication.
}
