# Resource Group
resource "azurerm_resource_group" "rg" {
  name = "${var.proj}-${var.env}-${var.names.rg}"
  location = "CentralUS"
}

#STORAGE ACCOUNT
resource "azurerm_storage_account" "storage" {
  name = "lower(${var.proj}${var.env}${var.names.storage}})"
  resource_group_name = "${azurerm_resource_group.rg}"
  location = "${azurerm_resource_group.rg}.location"
  account_tier = "Standard"
  account_replication_type = "GRS"
  
}

# VNET
resource "azurerm_virtual_network" "vnet" {
  name = "${var.proj}-${var.env}-${var.names.vnet}"
  resource_group_name = "${azurerm_resource_group.rg}"
  location = "${azurerm_resource_group.rg}.location"
  address_space = ["10.0.0.0/16"]
  
}

# SUB NET
resource "azurerm_subnet" "subnet" {
  name = "${var.proj}-${var.env}-${var.names.snet}}"
  resource_group_name = "${azurerm_resource_group.rg}"
  virtual_network_name = "${azurerm_virtual_network.vnet}"
  address_prefix = "10.0.0.0/24"
  
}

# PUBLIC IP
resource "azurerm_public_ip" "ip" {
  name = "${var.proj}-${var.env}-${var.names.ip}"
  location = "${azurerm_resource_group.rg}.location"
  resource_group_name = "${azurerm_resource_group.rg}"
  allocation_method = "Static"
    
}

# NSG
resource "azurerm_network_security_group" "nsg" {
  name = "${var.proj}-${var.env}-${var.names.nsg}"
  resource_group_name = "${azurerm_resource_group.rg}"
  location = "${azurerm_resource_group.rg}.location"

  security_rule  {
    name = "SSH"
    priority = 1001
    direction = "Inbound"
    access = "Allow"
    protocol = "Tcp"
    source_port_range = "*"
    destination_port_range = "22"
    source_address_prefix = "*"
    destination_address_prefix = "*"
  }

}

# NIC
resource "azurerm_network_interface" "nic" {
  name = "${var.proj}-${var.env}-${var.names.nsg}"
  resource_group_name = "${azurerm_resource_group.rg}"
  location = "${azurerm_resource_group.rg}.location"
    ip_configuration  {
    name = "myNICConfig"
    subnet_id = "${azurerm_subnet.subnet}.id"
    private_ip_address_allocation = "dynamic"
    public_ip_address_id = "${azurerm_public_ip.ip}.id"
  }
}

# Virtual Machine
resource "azurerm_virtual_machine" "vm" {
  name = "${var.proj}-${var.env}-${var.names.vm}}"
  resource_group_name = "${azurerm_resource_group.rg}"
  location = "${azurerm_resource_group.rg}.location"
  network_interface_ids = "${azurerm_network_interface.nic.id}"
  vm_size = "Standard_DS1_v2"
  storage_os_disk {
    name = "myOsDisk"
    caching = "ReadWrite"
    create_option = "FromImage"
  }

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04.0-LTS"
    version   = "latest"
    }

  os_profile {
    computer_name = "${var.proj}-${var.env}-${var.names.vm}"
    admin_username = "${var.vm-details.admin_username}"
    admin_password = "${var.vm-details.admin_password}"
  }
  boot_diagnostics {
  enabled = "true"
  storage_uri = "${azurerm_storage_account.storage.primary_blob_endpoint}"
}
  
}







