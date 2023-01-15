resource "helm_release" "argocd_release" {
  name              = "argocd"
  chart             = "argocd-helm-chart"
  repository        = "https://gitlab.com/api/v4/projects/42390521/packages/helm/stable"
  namespace         = var.argocd_ns
  create_namespace  = true
  dependency_update = true
  cleanup_on_fail   = true
}
