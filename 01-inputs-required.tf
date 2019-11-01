variable "subscription_id" {
  description                       = "Subscription ID to make the changes in"
}

variable "rg_name" {
  description                       = "Name of the rg to put the network in"
}

variable "rg_location" {
  description                       = "Location to build all the resources in"
  default                           = "UK South"
}

variable "vnet_name" {
  description                       = "Name of the vnet"
}

variable "vnet_cidr" {
  description                       = "CIDR of the vnet"
}

variable "subnet-public-prefix" {
  description                       = "Public IP Range Prefix"
  
}

variable "subnet-private-prefix" {
  description                       = "Private IP Range Prefix"
  
}

variable "subnet-mgmt-prefix" {
  description                       = "Management IP Range Prefix"
  
}



variable "environment" { }



variable "firewall_name_prefix" {
  default                     = "core-dmz-fw"
}

variable "firewall_username" {
  description                 = "Username to provision the VM with"
}

variable "firewall_password" {
  description                 = "Password to provision the VM with"
}


variable "firewall_replicas" {
  default                             = 1
}
