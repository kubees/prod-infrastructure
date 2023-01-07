terraform {
  required_version = ">= 1.3.0"
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.0.1"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0.1"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "helm" {
  kubernetes {
    config_path = "/tmp/kubeconfig"
  }
}

provider "kubernetes" {
  config_path = "/tmp/kubeconfig"
}
