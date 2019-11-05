resource "azurerm_log_analytics_workspace" "main" {
  name                = "hmcts-dmz-${var.environment}-law"
  location            = azurerm_resource_group.rg_hub.location
  resource_group_name = azurerm_resource_group.rg_hub.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}