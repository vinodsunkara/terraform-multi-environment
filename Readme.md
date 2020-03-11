# Create a mutli-environment Infrastructure with Terraform and Azure DevOps

### Files

|File Name | Description |
|--------- | ------------|
| main.tf | It contains all the resource configurations |
| mainvar.tf | Replace with the pipeline variables |
| variables.tf | variables |
| provider.tf | Provider is basically to configure or provisioning resources in different cloud environments |


# Terraform 

## Introduction

### Terraform Installation
Terraform is an open source flatform and just need to install the terraform package in target server if you want to start working.

**Installation:**
For windows, download the package from https://www.terraform.io/downloads.html and extract the file into any location. Now, set the terraform path in system advanced settings 

Open PC properties => Advanced system settings => Environment Variables => Edit => Paste the path

### Provider
Terraform provider can be defined within the infrastructure plan but are recommended to be stored in their own provider file. All files in your Terraform directory using the .tf file format will be automatically loaded during operations.


Provider is basically to configure or provisioning resources in different cloud environments. We can use the same configuration of terraform file in  multi-cloud environment by modifying the cloud provider name.

In this below block we are deploying the resources in azure

```
Provider "azurerm" {
	Version= "~>1.13.0"
}
```

The version is optional. It is used to constrain the provider to a specific version or a range of versions in order to prevent downloading a new provider that may possibly contain breaking changes. If the version isn't specified, Terraform will automatically download the most recent provider during initialization.