# Provider

provider "azurerm" {
  subscription_id = "${var.login_details.subscription_id}"
  tenant_id = "${var.login_details.tenant_id}"
  client_id = "${var.login_details.client_id}"
  client_secret = "${var.login_details.client_secret}"
  features {}
}