resource "kubernetes_secret" "fluentbit_secret" {
  metadata {
    name      = "elastic-auth"
    namespace = var.monitoring_ns
  }

  data = {
    FLUENT_ELASTICSEARCH_USER   = var.elastic_user
    FLUENT_ELASTICSEARCH_PASSWD = var.elastic_password
  }

  type = "kubernetes.io/opaque"
  depends_on = [
    kubernetes_namespace.monitoring
  ]
}

resource "kubernetes_namespace" "monitoring" {
  metadata {
    annotations = {
      name = var.monitoring_ns
    }
    name = var.monitoring_ns
  }
}
