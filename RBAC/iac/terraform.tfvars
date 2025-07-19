resource_names = {
  rg      = "transinfra"
  storage = "transst0987"
}

principal_access = [
  {
    name        = "viveksp"
    type        = "sp"
    role        = "Storage Blob Data Contributor"
    scope_label = "storage"
  },
  {
    name        = "test@vivekcoryahoo.onmicrosoft.com"
    type        = "user"
    role        = "Reader"
    scope_label = "rg"
  },
  {
    name        = "test@vivekcoryahoo.onmicrosoft.com"
    type        = "user"
    role        = "Storage Blob Data Contributor"
    scope_label = "storage"
  },
  {
    name        = "vivekappregistration"
    type        = "sp"
    role        = "Storage Blob Data Contributor"
    scope_label = "storage"
  }
]
