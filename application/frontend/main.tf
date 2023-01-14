resource "helm_release" "frontend_release" {
  name              = "frontend"
  chart             = "webapp-helm-chart"
  repository        = "https://gitlab.com/api/v4/projects/42388156/packages/helm/stable"
  namespace         = var.frontend_ns
  create_namespace  = true
  dependency_update = true
  cleanup_on_fail   = true
  set {
    name  = "deployment.container.digest"
    value = var.frontend_image_digest
  }
}
