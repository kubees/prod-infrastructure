resource "helm_release" "flagger_release" {
  name              = "flagger"
  chart             = "flagger-helm-chart"
  repository        = "https://gitlab.com/api/v4/projects/42579914/packages/helm/stable"
  namespace         = var.flagger_ns
  create_namespace  = true
  dependency_update = true
  cleanup_on_fail   = true
}
