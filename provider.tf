provider "azurerm" {
  subscription_id = "${var.azure_details.subscription_id}"
  tenant_id = "${var.azure_details.tenant_id}"
  client_id = "${var.azure_details.client_id}"
  client_secret = "${var.azure_details.client_secret}"
  features{}
}

terraform {
  backend "azurerm" {
    storage_account_name = "${terraformstorageaccount}"
    container_name = "${storagecontainer}"
    key = "${dev.tfstate}"
    access_key = "${storagekey}"
  }
}