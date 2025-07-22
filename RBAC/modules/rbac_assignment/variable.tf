variable "principal_access" {
  description = "List of principals with role and scope"
  type = list(object({
    name        = string
    type        = string
    role        = string
    scope_label = string
  }))
  validation {
    condition = length(distinct([
      for idx, p in var.principal_access : "${p.name}-${p.scope_label}-${idx}"
    ])) == length(var.principal_access)
    error_message = "Each principal-role-scope entry must be uniquely indexed. Duplicate combinations will cause errors."
  }
}

variable "resource_names" {
  description = "Map of scope labels to resource names"
  type        = map(string)
}
