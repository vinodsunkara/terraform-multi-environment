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
      subscription_id = "_subscription_id_"
      client_id = "_client_id_"
      tenant_id = "_tenant_id_"
      client_secret = "_client_secret_"
  }
}
