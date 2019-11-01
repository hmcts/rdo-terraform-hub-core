
resource "azurerm_network_interface" "ansible_server_nic" {
  name                                = "${azurerm_virtual_network.vnet_hub.name}-ansible-nic"
  location                            = "${azurerm_resource_group.rg_hub.location}"
  resource_group_name                 = "${azurerm_resource_group.rg_hub.name}"

    ip_configuration {
        name                          = "${azurerm_virtual_network.vnet_hub.name}-ansible-ip"
        subnet_id                     = "${azurerm_subnet.subnet-mgmt.id}"
        private_ip_address_allocation = "dynamic"
    }
}

module "firewall" {
  source                              = "github.com/hmcts/rdo-terraform-azure-palo-alto.git"
  rg_name                             = "${azurerm_resource_group.rg_hub.name}"
  vnet_name                           = "${azurerm_virtual_network.vnet_hub.name}"
  subnet_management_id                = "${azurerm_subnet.subnet-mgmt.id}"
  subnet_transit_private_id           = "${azurerm_subnet.subnet-private.id}"
  subnet_transit_public_id            = "${azurerm_subnet.subnet-public.id}"
  replicas                            = "${var.firewall_replicas}"
  vm_name_prefix                      = "${var.firewall_name_prefix}"
  vm_username                         = "${var.firewall_username}"
  vm_password                         = "${var.firewall_password}"
  environment                         = "${var.environment}"
  pip-ansible                         = "${azurerm_network_interface.ansible_server_nic.private_ip_address}"
  ansible-nic                         = "${azurerm_network_interface.ansible_server_nic.id}"

}

