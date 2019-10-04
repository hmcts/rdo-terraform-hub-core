resource "azurerm_network_security_group" "nsg_mgmt" {
  name                                = "nsg_mgmt"
  location                            = "${azurerm_resource_group.rg_hub.location}"
  resource_group_name                 = "${azurerm_resource_group.rg_hub.name}"
}

resource "azurerm_network_security_group" "nsg_transit_private" {
  name                                = "nsg_transit_private"
  location                            = "${azurerm_resource_group.rg_hub.location}"
  resource_group_name                 = "${azurerm_resource_group.rg_hub.name}"
}

resource "azurerm_network_security_group" "nsg_transit_public" {
  name                                = "nsg_transit_public"
  location                            = "${azurerm_resource_group.rg_hub.location}"
  resource_group_name                 = "${azurerm_resource_group.rg_hub.name}"
}



resource "azurerm_network_security_rule" "permit_trusted" {
  name                                = "permit_trusted"
  priority                            = 200
  direction                           = "Inbound"
  access                              = "Allow"
  protocol                            = "tcp"
  source_port_range                   = "*"
  destination_port_range              = "*"
  source_address_prefix               = "213.121.161.124/32"
  destination_address_prefix          = "*"
  resource_group_name                 = "${azurerm_resource_group.rg_hub.name}"
  network_security_group_name         = "${azurerm_network_security_group.nsg_mgmt.name}"
}

resource "azurerm_network_security_rule" "deny_all" {
  name                                = "deny_all"
  priority                            = 300
  direction                           = "Inbound"
  access                              = "Deny"
  protocol                            = "*"
  source_port_range                   = "*"
  destination_port_range              = "*"
  source_address_prefix               = "*"
  destination_address_prefix          = "*"
  resource_group_name                 = "${azurerm_resource_group.rg_hub.name}"
  network_security_group_name         = "${azurerm_network_security_group.nsg_mgmt.name}"
}



resource "azurerm_network_security_rule" "permit_trusted_private" {
  name                                = "permit_trusted"
  priority                            = 200
  direction                           = "Inbound"
  access                              = "Allow"
  protocol                            = "tcp"
  source_port_range                   = "*"
  destination_port_range              = "22"
  source_address_prefix               = "*"
  destination_address_prefix          = "*"
  resource_group_name                 = "${azurerm_resource_group.rg_hub.name}"
  network_security_group_name         = "${azurerm_network_security_group.nsg_transit_private.name}"
}

resource "azurerm_network_security_rule" "permit_all" {
  name                                = "permit_all"
  priority                            = 100
  direction                           = "Inbound"
  access                              = "Allow"
  protocol                            = "*"
  source_port_range                   = "*"
  destination_port_range              = "*"
  source_address_prefix               = "*"
  destination_address_prefix          = "*"
  resource_group_name                 = "${azurerm_resource_group.rg_hub.name}"
  network_security_group_name         = "${azurerm_network_security_group.nsg_transit_public.name}"
}


# Discovers the Azure DevOps IP Address

resource "azurerm_network_security_rule" "Azure_Devops" {
  name                                = "Azure_DataCenter_IPs"
  description		                      = "Azure_DataCenter_IPs"
  priority                            = 201
  direction                           = "Inbound"
  access                              = "Allow"
  protocol                            = "*"
  source_port_range                   = "*"
  destination_port_range              = "*"
  source_address_prefix               = "AzureCloud"
  destination_address_prefix          = "*"
  resource_group_name                 = "${azurerm_resource_group.rg_hub.name}"
  network_security_group_name         = "${azurerm_network_security_group.nsg_mgmt.name}"
}

