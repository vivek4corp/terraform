# Resolve Azure AD Users
data "azuread_user" "principals" {
  for_each = {
    for idx, p in var.principal_access :
    "${p.name}-${p.scope_label}-${idx}" => p
    if p.type == "user"
  }
  user_principal_name = each.value.name
}

# Resolve Azure AD Groups
data "azuread_group" "principals" {
  for_each = {
    for idx, p in var.principal_access :
    "${p.name}-${p.scope_label}-${idx}" => p
    if p.type == "group"
  }
  display_name = each.value.name
}

# Resolve Azure AD Service Principals
data "azuread_service_principal" "principals" {
  for_each = {
    for idx, p in var.principal_access :
    "${p.name}-${p.scope_label}-${idx}" => p
    if p.type == "sp"
  }
  display_name = each.value.name
}

# Resource Group
data "azurerm_resource_group" "rg" {
  name = var.resource_names["rg"]
}

# Storage Account
data "azurerm_storage_account" "storage" {
  name                = var.resource_names["storage"]
  resource_group_name = data.azurerm_resource_group.rg.name
}

# Key Vault (optional)
data "azurerm_key_vault" "kv" {
  count               = contains(keys(var.resource_names), "kv") ? 1 : 0
  name                = var.resource_names["kv"]
  resource_group_name = data.azurerm_resource_group.rg.name
}

# Data Factory (optional)
data "azurerm_data_factory" "adf" {
  count               = contains(keys(var.resource_names), "adf") ? 1 : 0
  name                = var.resource_names["adf"]
  resource_group_name = data.azurerm_resource_group.rg.name
}

# Databricks Workspace (optional)
data "azurerm_databricks_workspace" "adb" {
  count               = contains(keys(var.resource_names), "adb") ? 1 : 0
  name                = var.resource_names["adb"]
  resource_group_name = data.azurerm_resource_group.rg.name
}
