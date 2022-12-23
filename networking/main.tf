locals {
  environment = terraform.workspace
}

resource "azurerm_resource_group" "rg" {
  name     = "kubees-${local.environment}"
  location = var.location
}

resource "azurerm_virtual_network" "aks" {
  name                = "aks-vnet-${local.environment}"
  address_space       = ["10.1.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "aks" {
  name                 = "aks-subnet-${local.environment}"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.aks.name
  address_prefixes     = ["10.1.0.0/24"]
}
