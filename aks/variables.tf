variable "tenant_id" {
  type        = string
  description = "This is the Azure Tenant ID."
}
variable "location" {
  description = "Azure location to use"
}

variable "kubernetes_version" {
  description = "Kubernetes version to use"
}

variable "service_principal_client_id" {
  description = "The client id of the service principal to be used by AKS"
}

variable "service_principal_client_secret" {
  description = "The client secret of the service principal to be used by AKS"
}

variable "ssh_public_key" {
  description = "The SSH public key to use with Azure Kubernetes Service"
}
