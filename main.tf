provider "azurerm" {
    features {}
}

resource "azurerm_resource_group" "transithub" {
  name                      = var.project_name
  location                  = var.az_region
}
