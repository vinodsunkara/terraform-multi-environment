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
      subscription_id = "${subscriptionid}"
      client_id = "${clientid}"
      tenant_id = "${tenantid}"
      client_secret = "${clientsecret}"
  }
}
