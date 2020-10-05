resource "azurerm_cosmosdb_sql_database" "database" {
  name                = var.service_settings.name
  resource_group_name = var.context.resource_group_name
  account_name        = var.service_settings.account_name
  throughput          = var.service_settings.throughput

}


resource "azurerm_cosmosdb_sql_container" "erx" {

  dynamic "container" {
    
    for_each = var.container

    content {
          name                = var.container.name
          partition_key_path  = var.container.partition_key_path
          throughput          = var.service_settings.throughput
          resource_group_name = var.context.resource_group_name
          account_name        = var.service_settings.account_name
          database_name       = azurerm_cosmosdb_sql_database.database.name

    }


  }

  indexing_policy {
    indexing_mode = "Consistent"

    included_path {
      path = "/*"
    }

    excluded_path {
      path = "/\"_etag\"/?"
    }
  }
/*
  unique_key {
    paths = ["/definition/idlong", "/definition/idshort"]
  }
*/  
}