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
    resourcegroup = "${resourcegroup}"
    terraformstorageaccount = "${terraformstorageaccount}"
    storagecontainer = "${storagecontainer}"
    key = "${key}"
  }
}

