resource "helm_release" "redis_release" {
  name              = "redis"
  chart             = "redis-helm-chart"
  repository        = "https://gitlab.com/api/v4/projects/42388747/packages/helm/stable"
  namespace         = var.databases_ns
  create_namespace  = true
  version           = "v0.1.0"
  dependency_update = true
  set {
    name  = "redis.metrics.enabled"
    value = false
  }
  depends_on = [
    kubernetes_secret.redis_secret
  ]
}

resource "kubernetes_namespace" "databases" {
  metadata {
    annotations = {
      name = var.databases_ns
    }
    name = var.databases_ns
  }
}

resource "kubernetes_secret" "redis_secret" {
  metadata {
    name      = "redis-secret"
    namespace = var.databases_ns
  }

  data = {
    password = var.redis_password
  }

  type = "kubernetes.io/opaque"
  depends_on = [
    kubernetes_namespace.databases
  ]
}
