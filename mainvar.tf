# Lob Prefix

variable "lobprefix" {
  default = "${lobprefix}"
}
variable "environment" {
  default = "${environment}"
}

# Location
variable "location" {
  default = "${location}"
}

variable "azure_details" {
  default = {
      subscription_id = "${subscriptionid}"
      client_id = "${clientid}"
      tenant_id = "${tenantid}"
      client_secret = "${clientsecret}"
  }
}

variable "azurestorage" {
  default = {
    terraformstorageaccount = "${terraformstorageaccount}"
    storagecontainer = "${storagecontainer}"
    dev.tfstate = "${dev.tfstate}"
    storagekey = "${storagekey}"
  }
}

