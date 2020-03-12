# Backend storage for state files

terraform {
  backend "azurerm" {
    resource_group_name = "${var.azurestorage.resourcegroup}"
    storage_account_name = "${var.azurestorage.terraformstorageaccount}"
    container_name = "${var.azurestorage.storagecontainer}"
    key = "${var.azurestorage.key}"
  }
}


# Local Values
locals  {
 region_short_name = "${lookup (var.shortname, var.location, var.region)}"
 resource_name = "${var.lobprefix}-${var.environment}"
 vnet_address_space = "${lookup(var.vnet_address_space, var.environment)}"
 subnet_address_prefix = "${lookup(var.subnet_address_prefix, var.environment)}"
 vm_size = "${lookup(var.vm_size, var.environment)}"
}


# Resource Group 
resource "azurerm_resource_group" "rg" {
  name = "${local.resource_name}-${local.region_short_name}-RG"
  location = "${var.location}"
}

# Storage Account

resource "azurerm_storage_account" "storage" {
  name = "${lower("${local.region_short_name}${var.environment}")}"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  location = "${azurerm_resource_group.rg.location}"
  account_tier = "Standard"
  account_replication_type = "GRS"

  
}

# Virtual Network

resource "azurerm_virtual_network" "vnet" {
  name = "${local.resource_name}-${local.region_short_name}-VNET"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  location = "${azurerm_resource_group.rg.location}"
  address_space = ["${local.vnet_address_space}"]


}

# SUB NET
resource "azurerm_subnet" "snet" {
  name = "${local.resource_name}-${local.region_short_name}-SNET"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  virtual_network_name = "${azurerm_virtual_network.vnet.name}"
  address_prefix = "${local.subnet_address_prefix}"
}

# IP Address

resource "azurerm_public_ip" "ip" {
  name = "${local.resource_name}-${local.region_short_name}-IP"
  location = "${azurerm_resource_group.rg.location}"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  allocation_method = "Static"
}


# NSG - Network Security Group

resource "azurerm_network_security_group" "nsg" {
  name = "${local.resource_name}-${local.region_short_name}-NSG"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  location = "${azurerm_resource_group.rg.location}"

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


# NIC - Network Interface Card

resource "azurerm_network_interface" "nic" {
  name = "${local.resource_name}-${local.region_short_name}-NIC"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  location = "${azurerm_resource_group.rg.location}"
  ip_configuration {

    name = "myNICConfig"
    subnet_id = "${azurerm_subnet.snet.id}"
    private_ip_address_allocation = "dynamic"
    public_ip_address_id = "${azurerm_public_ip.ip.id}"
  }
}


# Virtual Machine
resource "azurerm_linux_virtual_machine" "vm" {
  name = "${local.resource_name}-${local.region_short_name}-VM"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  location = "${azurerm_resource_group.rg.location}"
  network_interface_ids = ["${azurerm_network_interface.nic.id}"]
  vm_size = "${local.vm_size}"
    
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
        computer_name = "${local.resource_name}-${local.region_short_name}-VM"
        admin_username = "admin"
        admin_password = "Administrator@123"
  }
    boot_diagnostics {
        enabled = "true"
        storage_uri = "${azurerm_storage_account.storage.primary_blob_endpoint}"
}


}

