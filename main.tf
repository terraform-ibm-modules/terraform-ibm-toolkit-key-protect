provider "ibm" {
  version = ">= 1.9.0"
}

data "ibm_resource_group" "resource_group" {
  name = var.resource_group_name
}

locals {
  name_prefix = var.name_prefix != "" ? var.name_prefix : var.resource_group_name
  name        = var.name != "" ? var.name : "${replace(local.name_prefix, "/[^a-zA-Z0-9_\\-\\.]/", "")}-keyprotect"
  bind        = (var.provision || (!var.provision && var.name != "")) && var.cluster_name != ""
  module_path = substr(path.module, 0, 1) == "/" ? path.module : "./${path.module}"
  service_endpoints = var.private_endpoint == "true" ? "private" : "public"
}

resource "ibm_resource_instance" "keyprotect_instance" {
  count = var.provision ? 1 : 0

  name              = local.name
  service           = "kms"
  plan              = var.plan
  location          = var.region
  resource_group_id = data.ibm_resource_group.resource_group.id
  tags              = var.tags

  parameters = {
    service-endpoints = local.service_endpoints
  }

  timeouts {
    create = "15m"
    update = "15m"
    delete = "15m"
  }
}

data "ibm_resource_instance" "keyprotect_instance" {
  count             = local.bind ? 1 : 0
  depends_on        = [ibm_resource_instance.keyprotect_instance]

  name              = local.name
  resource_group_id = data.ibm_resource_group.resource_group.id
  location          = var.region
  service           = "kms"
}
