resource "helm_release" "nginx-ingress-controller" {
  name = "ingress-nginx"

  repository        = "https://kubernetes.github.io/ingress-nginx"
  chart             = "ingress-nginx"
  namespace         = "ingress-nginx"
  create_namespace  = true
  dependency_update = true

  set {
    name  = "controller.metrics.enabled"
    value = "true"
  }

  set {
    name  = "controller.podAnnotations.\"prometheus\\.io/scrape\""
    value = "true"
  }

  set {
    name  = "controller.podAnnotations.\"prometheus\\.io/scrape\""
    value = "10254"
  }
}
