resource "azurerm_resource_group" "rg_hub" {
  name                                = "${var.rg_name}"
  location                            = "${var.rg_location}"
}
