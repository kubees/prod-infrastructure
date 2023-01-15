resource "kubernetes_secret" "prometheus_secret" {
  metadata {
    name      = "grafana-secret"
    namespace = var.monitoring_ns
  }

  data = {
    password = var.grafana_password
    username = var.grafana_username
  }

  type = "kubernetes.io/opaque"
  depends_on = [
    kubernetes_namespace.monitoring
  ]
}
