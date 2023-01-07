resource "helm_release" "frontend_release" {
  name              = "argocd"
  chart             = "argocd-helm-chart"
  repository        = "https://gitlab.com/api/v4/projects/42390521/packages/helm/api/stable/charts"
  namespace         = var.argocd_ns
  create_namespace  = true
  dependency_update = true
  cleanup_on_fail   = true
}
