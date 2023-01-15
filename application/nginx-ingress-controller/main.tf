resource "helm_release" "nginx-ingress-controller" {
  name              = "nginx-ingress"
  repository        = "https://gitlab.com/api/v4/projects/42580517/packages/helm/stable"
  chart             = "nginx-ingress-helm-chart"
  namespace         = var.nginx_ingress_controller_ns
  create_namespace  = true
  dependency_update = true

}
