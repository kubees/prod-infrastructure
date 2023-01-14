locals {
  environment = terraform.workspace
}

// replace with remote state
data "azurerm_resource_group" "rg" {
  name = "kubees-${local.environment}"
}

// replace with remote state
data "azurerm_subnet" "aks" {
  name                 = "aks-subnet-${local.environment}"
  virtual_network_name = "aks-vnet-${local.environment}"
  resource_group_name  = data.azurerm_resource_group.rg.name
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                            = "aks-${local.environment}"
  location                        = data.azurerm_resource_group.rg.location
  resource_group_name             = data.azurerm_resource_group.rg.name
  dns_prefix                      = "aks-${local.environment}"
  kubernetes_version              = var.kubernetes_version
  api_server_authorized_ip_ranges = ["0.0.0.0/0"]

  linux_profile {
    admin_username = "azureuser"
    ssh_key {
      key_data = var.ssh_public_key
    }
  }

  default_node_pool {
    name            = "default"
    node_count      = "2"
    vm_size         = "Standard_DS2_v2"
    os_disk_size_gb = 30

    vnet_subnet_id = data.azurerm_subnet.aks.id
  }

  service_principal {
    client_id     = var.service_principal_client_id
    client_secret = var.service_principal_client_secret
  }

  network_profile {
    network_plugin = "kubenet"
    network_policy = "calico"
  }

  oms_agent {
    log_analytics_workspace_id = azurerm_log_analytics_workspace.logs.id
  }

  role_based_access_control_enabled = true

  tags = {
    Environment = local.environment
  }
}

data "azuread_service_principal" "aks" {
  application_id = var.service_principal_client_id
}

resource "azurerm_role_assignment" "netcontribrole" {
  scope                = data.azurerm_subnet.aks.id
  role_definition_name = "Network Contributor"
  principal_id         = data.azuread_service_principal.aks.object_id
}
