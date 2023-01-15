resource "kubernetes_secret" "jaeger_secret" {
  metadata {
    name      = "jaeger-elastic-secret"
    namespace = var.jaeger_ns
  }

  data = {
    password = var.elastic_password
  }

  type = "kubernetes.io/opaque"
  depends_on = [
    kubernetes_namespace.jaeger
  ]
}

resource "kubernetes_namespace" "jaeger" {
  metadata {
    annotations = {
      name = var.jaeger_ns
    }
    name = var.jaeger_ns
  }
}
