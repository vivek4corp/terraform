output "role_assignments_summary" {
  description = "Summary of role assignments by principal and scope"
  value = {
    for key, assignment in azurerm_role_assignment.rbac :
    key => {
      principal_id         = assignment.principal_id
      scope                = assignment.scope
      role_definition_name = assignment.role_definition_name
    }
  }
}
