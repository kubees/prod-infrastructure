output "resource_group_name" {
  value       = data.azurerm_resource_group.rg.name
  description = "This is the resource group name"
}
