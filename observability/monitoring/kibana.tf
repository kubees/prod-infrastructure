resource "kubernetes_secret" "kibana_secret" {
  metadata {
    name      = "kibana-elastic-secret"
    namespace = var.monitoring_ns
  }

  data = {
    username = var.elastic_user
    password = var.elastic_password
  }

  type = "kubernetes.io/opaque"
  depends_on = [
    kubernetes_namespace.monitoring
  ]
}
