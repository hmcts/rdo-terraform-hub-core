resource "azurerm_public_ip" "pip-ansible" {
  name                                = "${azurerm_virtual_network.vnet_hub.name}-ansible-pip"
  location                            = "${azurerm_resource_group.rg_hub.location}"
  resource_group_name                 = "${azurerm_resource_group.rg_hub.name}"
  allocation_method                   = "Static"
}

resource "azurerm_network_interface" "ansible_server_nic" {
  name                                = "${azurerm_virtual_network.vnet_hub.name}-ansible-nic"
  location                            = "${data.azurerm_resource_group.rg_hub.location}"
  resource_group_name                 = "${data.azurerm_resource_group.rg_hub.name}"

    ip_configuration {
        name                          = "${data.azurerm_virtual_network.vnet_hub.name}-ansible-ip"
        subnet_id                     = "${data.azurerm_subnet.sub-hub-mgmt.id}"
        private_ip_address_allocation = "dynamic"
        public_ip_address_id          = "${azurerm_public_ip.pip-ansible.id}"
    }
}

module "firewall" {
  source                              = "github.com/hmcts/rdo-terraform-azure-palo-alto.git"
  rg_name                             = "${azurerm_resource_group.rg_hub.name}"
  vnet_name                           = "${azurerm_virtual_network.vnet_hub.name}"
  subnet_management_id                = "${azurerm_subnet.sub-hub-mgmt.id}"
  subnet_transit_private_id           = "${azurerm_subnet.sub-hub-transit-private.id}"
  subnet_transit_public_id            = "${azurerm_subnet.sub-hub-transit-public.id}"
  replicas                            = "${var.firewall_replicas}"
  vm_name_prefix                      = "${var.firewall_name_prefix}"
  vm_username                         = "${var.firewall_username}"
  vm_password                         = "${var.firewall_password}"
  environment                         = "${var.environment}"
  pip-ansible                         = "${azurerm_public_ip.pip-ansible.ip_address}"
  ansible-nic                         = "${azurerm_network_interface.ansible_server_nic.id}"
}

