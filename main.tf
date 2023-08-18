

locals {
  
  targets_map = { for target in var.target_ids : target => true }
}

data "azurerm_eventhub_authorization_rule" "main" {
  name                = "RootManageSharedAccessKey"
  namespace_name      = var.eventhub_namespace_name
  eventhub_name       = var.eventhub_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_monitor_diagnostic_setting" "main" {
  for_each = local.targets_map

  name                           = "${var.name}-diag"
  target_resource_id             = each.key
  eventhub_authorization_rule_id = data.azurerm_eventhub_authorization_rule.main.id
  eventhub_name                  = var.eventhub_name

  dynamic "log" {
    for_each = var.logs
    content {
      category = log.value

      retention_policy {
        enabled = false
      }
    }
  }

  dynamic "metric" {
    for_each = var.metrics
    content {
      category = metric.value

      retention_policy {
        enabled = false
      }
    }
  }
}