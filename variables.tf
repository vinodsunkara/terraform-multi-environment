# Project Name

variable "proj" {
  default = "VIN"
}

# Environments

variable "env" {

  default = {
    dev = "DEV"
    stage = "STAGE"
    qa = "QA"
    prod = "PROD"
  }
}

# Names
variable "names" {
    default = {
      rg = "RG"
      vnet = "VNET"
      snet = "SUBNET"
      nic = "NIC"
      stoarage = "STORAGE"
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




