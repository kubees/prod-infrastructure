locals {
  nginx_ingress_controller_ns = "ingress-nginx"
  microservices_ns            = "microservices"
  databases_ns                = "databases"
  frontend_ns                 = "frontend"
}

module "nginx-ingress-controller" {
  source                      = "./nginx-ingress-controller"
  nginx_ingress_controller_ns = local.nginx_ingress_controller_ns
}

module "redis" {
  source         = "./redis"
  redis_password = var.redis_password
  databases_ns   = local.databases_ns
}

module "microservices" {
  source             = "./microservices"
  redis_password     = var.redis_password
  microservices_ns   = local.microservices_ns
  playlist_ms_digest = var.playlist_ms_digest
  videos_ms_digest   = var.videos_ms_digest
  depends_on = [
    module.redis
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
