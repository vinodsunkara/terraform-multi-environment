# Regions Short Name using interpolation lookup syntax

variable "region" {
    default = {
      centralus = "centralus"
      eastus = "eastus"
      westus2 = "westus2"
  }
}
variable "shortname" {
    default = {
     centralus = "CUA01"
     eastus = "EUA01"
     westus2 = "WUA01"
    }
}

# VNET address space based on the environment

variable "vnet_address_space" {
  default = {
      DEV = "10.0.2.0/24"
      PROD = "10.0.3.0/24"
      DR = "10.0.4.0/24"
  }
}

variable "subnet_address_prefix" {
  default = {
      DEV = "10.0.2.0/24"
      PROD = "10.0.3.0/24"
      DR = "10.0.4.0/24"
  }
}

# VM Size
variable "vm_size" {
  default = {
      DEV = "Standard_DS1_v2"
      DR = "Standard_DS2_v2"
      PROD = "Standard_DS3_v2"
  }
}


