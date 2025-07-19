variable "principal_access" {
  description = "List of principals with role and scope"
  type = list(object({
    name        = string
    type        = string
    role        = string
    scope_label = string
  }))
}

variable "resource_names" {
  description = "Map of scope labels to actual Azure resource names"
  type        = map(string)
}
