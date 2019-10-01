provider "azurerm" {
  version = "=1.34.0"
}

resource "azurerm_resource_group" "TerraformCloudRG" {
  name     = "TerraformCloud"
  location = var.location

  tags = {
    terraform = "Terraform Cloud"
  }
}

resource "azurerm_sql_server" "sql_server" {
  name                         = var.sql_server_database_name
  resource_group_name          = azurerm_resource_group.TerraformCloudRG.name
  location                     = var.location
  version                      = "12.0"
  administrator_login          =  var.sql_server_user
  administrator_login_password =  var.sql_server_password
  tags = {
    terraform = "Terraform Cloud"
  }
}


resource "azurerm_sql_database" "sql_database" {
  name                = azurerm_sql_server.sql_server.name
  resource_group_name = azurerm_resource_group.TerraformCloudRG.name
  location            = var.location
  server_name         = azurerm_sql_server.sql_server.name

  tags = {
    terraform = "Terraform Cloud"
  }
}
