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
      subscription_id = "1b85196d-f957-4779-8d3f-4a335a64c4a7"
      client_id = "a8451363-c0f8-4df6-9538-bc66647ca6c1"
      tenant_id = "b7799b39-1302-4ad7-b54b-c6036c12fd2c"
      client_secret = "4N[k@Vty_phczsTpKNllWNL3G=VvWW88"
  }
}
