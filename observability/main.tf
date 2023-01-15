locals {
  databases_ns  = "databases"
  argocd_ns     = "argocd"
  monitoring_ns = "monitoring"
  jaeger_ns     = "jaeger"
}

module "argocd" {
  source    = "./argocd"
  argocd_ns = local.argocd_ns
  depends_on = [
    module.monitoring
  ]
}
module "monitoring" {
  source           = "./monitoring"
  monitoring_ns    = local.monitoring_ns
  elastic_password = var.elastic_password
  elastic_user     = var.elastic_user
  grafana_password = var.grafana_password
  grafana_username = var.grafana_username
  jaeger_ns        = local.jaeger_ns
}
