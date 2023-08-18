

locals {  
  targets_map = { for target in var.target_ids : target => true }
  metrics_enabled = length(var.metrics) == 0 ? false : true
  metrics = length(var.metrics) == 0 ? ["AllMetrics"] : var.metrics
  
}

data "azurerm_eventhub_namespace_authorization_rule" "main" {
  name                = var.auth_rule_name
  namespace_name      = var.eventhub_namespace_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_monitor_diagnostic_setting" "main" {
  for_each = local.targets_map

  name                           = "${var.name}-diag"
  target_resource_id             = each.key
  eventhub_authorization_rule_id = data.azurerm_eventhub_namespace_authorization_rule.main.id
  eventhub_name                  = var.eventhub_name

  dynamic "enabled_log" {
    for_each = var.logs
    content {
      category = enabled_log.value

      retention_policy {
        enabled = false
      }
    }
  }

  dynamic "metric" {
    for_each = local.metrics
    content {
      category = metric.value
      enabled = local.metrics_enabled

      retention_policy {
        enabled = false
      }
    }
  }
}