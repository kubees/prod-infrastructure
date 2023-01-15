resource "kubernetes_secret" "elastic_secret" {
  metadata {
    name      = "elastic-secret"
    namespace = var.monitoring_ns
  }

  data = {
    ELASTIC_PASSWORD = var.elastic_password
  }

  type = "kubernetes.io/opaque"
  depends_on = [
    kubernetes_namespace.monitoring
  ]
}
