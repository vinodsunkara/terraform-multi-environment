# Environments

variable "env" {

  default = {
    environment = "DEV"
  }
}


# Project Name

variable "proj" {
  default = "VIN"
}

# Names
variable "names" {
    default = {
      rg = "RG"
      vnet = "VNET"
      snet = "SUBNET"
      nic = "NIC"
      storage = "STORAGE"
      ip = "IP"
      nsg = "NSG"
      vm = "VM"
   }  
}

variable "vm-details" {
  default = {
    admin_username = "vinodsunkara"
    admin_password = "Administrator@123"
  }
}

variable "VNET_ADDRESS_SPACE" {
  default = "10.0.0.0/16"
}

variable "SUBNET_ADDRESS_PREFIX" {
  default = "10.0.0.0/24"
}








