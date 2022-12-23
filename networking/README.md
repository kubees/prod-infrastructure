<!-- BEGIN_TF_DOCS -->
# Core Module

This module is responsible for the deployment for all the core components and resources for a given environment, like:

- The resource group
- The virtual network
- The subnets
---
## Usage
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | =3.33.0 |
## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.33.0 |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_location"></a> [location](#input\_location) | Azure location to use | `string` | `"France Central"` | no |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | This is the resource group name |
<!-- END_TF_DOCS -->
