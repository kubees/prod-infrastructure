resource "helm_release" "flagger_release" {
  name              = "flagger"
  chart             = "flagger/flagger"
  repository        = "https://flagger.app"
  namespace         = var.flagger_ns
  create_namespace  = true
  dependency_update = true
  cleanup_on_fail   = true
  set {
    name  = "meshProvider"
    value = "nginx"
  }
  set {
    name  = "metricsServer"
    value = "http://prometheus-stack-kube-prom-prometheus.monitoring:9090"
  }
}
