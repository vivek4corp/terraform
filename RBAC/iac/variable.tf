variable "resource_names" {
  description = "Map of Azure resource labels to their actual names"
  type        = map(string)
}

variable "principal_access" {
  description = "List of principals with role and target scope"
  type = list(object({
    name        = string
    type        = string  # Valid values: "user", "group", "sp"
    role        = string
    scope_label = string  # e.g. "rg", "storage", "kv"
  }))
}
