output "id" {
  description = "The id of the diagnostic settings."
  value       = { for k, v in azurerm_monitor_diagnostic_setting.main : k => v.id }
}