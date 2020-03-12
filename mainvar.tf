# Lob Prefix

variable "lobprefix" {
  default = "VINIT"
}
variable "environment" {
  default = "DEV"
}

# Location
variable "location" {
  default = "eastus"
}

variable "azure_details" {
  default = {
      subscription_id = "_subscriptionid_"
      client_id = "_clientid_"
      tenant_id = "_tenantid_"
      client_secret = "_clientsecret_"
  }
}
