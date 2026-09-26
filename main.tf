# 1. Create a dedicated test namespace
resource "kubernetes_namespace" "test" {
  metadata {
    name = "atlantis-test"
    labels = {
      managed-by = "atlantis"
      environment = "local-k8s"
    }
  }
}

# 2. Create a test ConfigMap
resource "kubernetes_config_map" "test_config" {
  metadata {
    name      = "demo-config"
    namespace = kubernetes_namespace.test.metadata[0].name
  }

  data = {
    "welcome.txt" = "Hello from Atlantis and Terraform on Docker Desktop Kubernetes!"
    "created_by"  = "Terraform"
  }
}

# 3. Create a lightweight Nginx Pod
resource "kubernetes_pod" "nginx_demo" {
  metadata {
    name      = "nginx-demo"
    namespace = kubernetes_namespace.test.metadata[0].name
    labels = {
      app = "nginx-demo"
    }
  }

  spec {
    container {
      name  = "nginx"
      image = "nginx:alpine"

      port {
        name           = "http"
        container_port = 80
      }

      resources {
        limits = {
          cpu    = "200m"
          memory = "128Mi"
        }
        requests = {
          cpu    = "50m"
          memory = "64Mi"
        }
      }
    }
  }
}

# 4. Expose the Pod with a Service
resource "kubernetes_service" "nginx_service" {
  metadata {
    name      = "nginx-service"
    namespace = kubernetes_namespace.test.metadata[0].name
  }

  spec {
    selector = {
      app = kubernetes_pod.nginx_demo.metadata[0].labels.app
    }

    port {
      port        = 80
      target_port = 80
    }

    type = "ClusterIP"
  }
}
