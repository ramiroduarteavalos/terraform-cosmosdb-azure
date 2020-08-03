## Azure resource provider ##
provider "azurerm" {
  version = ">= 0.12"
  features {}
}

resource "azurerm_cosmosdb_account" "main" {
  name                = var.cosmosdb
  location            = var.location
  resource_group_name = var.resource_group_name  
  offer_type          = "Standard"
  kind                = "MongoDB"
  is_virtual_network_filter_enabled = "true"
  ip_range_filter     = var.ip_range_filter

  enable_automatic_failover = false

  consistency_policy {
    consistency_level       = "Session"
    max_interval_in_seconds = 5
    max_staleness_prefix    = 100
  }

  geo_location {
    location          = var.location
    failover_priority = 0
  }

  virtual_network_rule  {
    id                = var.vnet_subnet_id
    ignore_missing_vnet_service_endpoint = true
  }
  
}

#resource "azurerm_cosmosdb_mongo_database" "db" {
#  name                = azurerm_cosmosdb_account.main.name
#  resource_group_name = var.resource_group_name
#  account_name        = azurerm_cosmosdb_account.main.name
#}
