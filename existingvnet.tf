data "azurerm_subnet" "example" {
  name                 = "Subnet-3"
  virtual_network_name = "VNET-Prod-192"
  resource_group_name  = "Group-AMS-VNET-190"
}