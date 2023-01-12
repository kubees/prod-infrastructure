resource "helm_release" "videos_microservice_release" {
  name              = "videos"
  chart             = "videos-helm-chart"
  repository        = "https://gitlab.com/api/v4/projects/42388109/packages/helm/stable"
  namespace         = var.microservices_ns
  version           = "v0.1.0"
  create_namespace  = true
  dependency_update = true
  cleanup_on_fail   = true

  set {
    name  = "microservices-umbrella-chart.deployment.container.digest"
    value = var.videos_ms_digest
  }

  set {
    name  = "microservices-umbrella-chart.monitoring.enabled"
    value = false
  }
}

resource "kubernetes_secret" "videos_redis_secret" {
  metadata {
    name      = "videos-redis-secret"
    namespace = var.microservices_ns
  }

  # Since it's a test infrastructure it is okay to use plaintext
  data = {
    PASSWORD = var.redis_password
  }

  type = "kubernetes.io/opaque"
  depends_on = [
    kubernetes_namespace.microservices
  ]
}

resource "helm_release" "playlist_microservice_release" {
  name              = "playlist"
  chart             = "playlist-helm-chart"
  repository        = "https://gitlab.com/api/v4/projects/42388143/packages/helm/stable"
  version           = "v0.1.0"
  namespace         = var.microservices_ns
  create_namespace  = true
  dependency_update = true
  cleanup_on_fail   = true

  set {
    name  = "microservices-umbrella-chart.deployment.container.digest"
    value = var.playlist_ms_digest
  }

  set {
    name  = "microservices-umbrella-chart.monitoring.enabled"
    value = false
  }
}

resource "kubernetes_secret" "playlist_redis_secret" {
  metadata {
    name      = "redis-secret"
    namespace = var.microservices_ns
  }

  # Since it's a test infrastructure it is okay to use plaintext
  data = {
    PASSWORD = var.redis_password
  }

  type = "kubernetes.io/opaque"

  depends_on = [
    kubernetes_namespace.microservices
  ]
}

resource "kubernetes_namespace" "microservices" {
  metadata {
    annotations = {
      name = var.microservices_ns
    }
    name = var.microservices_ns
  }
}
