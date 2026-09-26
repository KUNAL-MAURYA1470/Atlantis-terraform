output "namespace" {
  description = "The created Kubernetes namespace name"
  value       = kubernetes_namespace.test.metadata[0].name
}

output "config_map_name" {
  description = "The name of the created ConfigMap"
  value       = kubernetes_config_map.test_config.metadata[0].name
}

output "pod_name" {
  description = "The name of the test Nginx Pod"
  value       = kubernetes_pod.nginx_demo.metadata[0].name
}

output "service_name" {
  description = "The name of the created Service"
  value       = kubernetes_service.nginx_service.metadata[0].name
}
