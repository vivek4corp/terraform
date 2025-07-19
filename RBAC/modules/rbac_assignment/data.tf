data "azurerm_resource_group" "rg" {
  count = contains(keys(var.resource_names), "rg") ? 1 : 0
  name  = lookup(var.resource_names, "rg", "")
}

data "azurerm_storage_account" "storage" {
  count               = contains(keys(var.resource_names), "storage") ? 1 : 0
  name                = lookup(var.resource_names, "storage", "")
  resource_group_name = lookup(var.resource_names, "rg", "")
}

data "azurerm_key_vault" "kv" {
  count               = contains(keys(var.resource_names), "kv") ? 1 : 0
  name                = lookup(var.resource_names, "kv", "")
  resource_group_name = lookup(var.resource_names, "rg", "")
}

data "azurerm_databricks_workspace" "adb" {
  count               = contains(keys(var.resource_names), "adb") ? 1 : 0
  name                = lookup(var.resource_names, "adb", "")
  resource_group_name = lookup(var.resource_names, "rg", "")
}

data "azurerm_data_factory" "adf" {
  count               = contains(keys(var.resource_names), "adf") ? 1 : 0
  name                = lookup(var.resource_names, "adf", "")
  resource_group_name = lookup(var.resource_names, "rg", "")
}

data "azuread_user" "principals" {
  for_each = {
    for p in var.principal_access : "${p.name}-${p.scope_label}" => p
    if p.type == "user"
  }
  user_principal_name = each.value.name
}

data "azuread_group" "principals" {
  for_each = {
    for p in var.principal_access : "${p.name}-${p.scope_label}" => p
    if p.type == "group"
  }
  display_name = each.value.name
}

data "azuread_service_principal" "principals" {
  for_each = {
    for p in var.principal_access : "${p.name}-${p.scope_label}" => p
    if p.type == "sp"
  }
  display_name = each.value.name
}
