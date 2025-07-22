locals {
  scope_map = {
    rg      = try(data.azurerm_resource_group.rg.id, null)
    storage = try(data.azurerm_storage_account.storage.id, null)
    kv      = try(data.azurerm_key_vault.kv[0].id, null)
    adf     = try(data.azurerm_data_factory.adf[0].id, null)
    adb     = try(data.azurerm_databricks_workspace.adb[0].id, null)
  }

  resolved_access = [
    for idx, p in var.principal_access : {
      key          = "${p.name}-${p.scope_label}-${idx}"
      name         = p.name
      type         = p.type
      role         = p.role
      scope_label  = p.scope_label
      principal_id = (
        p.type == "user"  ? data.azuread_user.principals["${p.name}-${p.scope_label}-${idx}"].object_id :
        p.type == "group" ? data.azuread_group.principals["${p.name}-${p.scope_label}-${idx}"].object_id :
        data.azuread_service_principal.principals["${p.name}-${p.scope_label}-${idx}"].object_id
      )
      scope_id = local.scope_map[p.scope_label]
    }
  ]
}

resource "azurerm_role_assignment" "rbac" {
  for_each = {
    for a in local.resolved_access : a.key => a
    if a.scope_id != null
  }

  scope                = each.value.scope_id
  role_definition_name = each.value.role
  principal_id         = each.value.principal_id
}
