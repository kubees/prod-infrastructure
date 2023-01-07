locals {
  nginx_ingress_controller_ns = "ingress-nginx"
  microservices_ns            = "microservices"
  database_ns                 = "databases"
  frontend_ns                 = "frontend"
  argocd_ns                   = "automation"
}

module "nginx-ingress-controller" {
  source                      = "./nginx-ingress-controller"
  nginx_ingress_controller_ns = local.nginx_ingress_controller_ns
}
