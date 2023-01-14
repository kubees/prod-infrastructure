locals {
  nginx_ingress_controller_ns = "ingress-nginx"
  microservices_ns            = "microservices"
  databases_ns                = "databases"
  frontend_ns                 = "frontend"
  argocd_ns                   = "argocd"
  flagger_ns                  = "flagger"
  monitoring_ns               = "monitoring"
}

module "nginx-ingress-controller" {
  source                      = "./nginx-ingress-controller"
  nginx_ingress_controller_ns = local.nginx_ingress_controller_ns
}

module "argocd" {
  source    = "./argocd"
  argocd_ns = local.argocd_ns
  depends_on = [
    module.databases, module.monitoring
  ]
}

module "databases" {
  source           = "./databases"
  redis_password   = var.redis_password
  databases_ns     = local.databases_ns
  elastic_password = var.elastic_password
}

module "microservices" {
  source             = "./microservices"
  redis_password     = var.redis_password
  microservices_ns   = local.microservices_ns
  playlist_ms_digest = var.playlist_ms_digest
  videos_ms_digest   = var.videos_ms_digest
  depends_on = [
    module.databases
  ]
}

module "frontend" {
  source                = "./frontend"
  frontend_ns           = local.frontend_ns
  frontend_image_digest = var.frontend_image_digest
  depends_on = [
    module.microservices
  ]
}

module "monitoring" {
  source           = "./monitoring"
  monitoring_ns    = local.monitoring_ns
  elastic_password = var.elastic_password
  elastic_user     = var.elastic_user
  grafana_password = var.grafana_password
  grafana_username = var.grafana_username
}
