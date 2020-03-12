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

### ARM vs Terraform
![](Images/armVSterraform.png)

### Syntax
![](Images/JSONvsHCL.png)

### Resources syntax (ARM vs HCL)
![](Images/resources_syntax.png)

### Benifits of using Terraform for Azure
* Use terraform as you won't have to learn any tools since it is easy to write, and easy to understand. 
* The Terraform enables users to validate and preview infrastructure changes before application. 
* Deploys the same template multiple times to create identical development, test, and production environments.
* Unintended changes can be caught early in the development process


### Terraform Installation
Terraform is an open source flatform and just need to install the terraform package in target server if you want to start working.

**Installation:**
For windows, download the package from https://www.terraform.io/downloads.html and extract the file into any location. Now, set the terraform path in system advanced settings 

Open PC properties :arrow_forward: Advanced system settings :arrow_forward: Environment Variables :arrow_forward: Edit :arrow_forward: Paste the path

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

With in the provider block you can define the azure account login details like below or you can define those details in the variables.tf file

```
provider "azurerm" {
	
	subscription_id = "********"
	tenant_id = "*********"
	client_id = "*********"
	client_secret = "*********"
	features {}
}
```

### Terraform Authentication
![](Images/authentication.png)

**We can authenticate the deployment in several ways by using the following methods.**

***Using Azure CLI***
s
This method is good when you are working in your local environment
```
Az login
Az account set --sub "****************"
```
***Using MSI (Managed Service Identity)***

Managed identities for Azure resources is a feature of Azure Active Directory (Azure AD). Using a managed identity for the Terraform host VM or container removes the need to pass a client secret or certificate to Terraform.

```
Provider "azurerm" {
	Version = "~> 0.32.0"
	Use_msi= "true"
	Subscription_id=""
	Tenant_id=""
}
```
***Using Service Principal ID and secret***

A Service Principal is an application within Azure Active Directory whose authentication tokens can be used as the client_id, client_secret, and tenant_id

* Create a new active directory application in azure portal
* Create a new client secret 
* Now, you need to assign the RBAC for the application in subscription scope or resource group scope level (as required)

```
Provider "azurerm" {
	Version = "~1.30.0"
	Subscription_id = ""
	Tenant_id=""
	Client_id=""
	Client_secret=""
}
```
***Using Service Principal ID and certificate***
https://www.terraform.io/docs/providers/azurerm/guides/service_principal_client_certificate.html

### Syntax Validate
* Terraform Validate can run pre-deployment checks for any syntax errors in the configuration before deployment.
* If the validation fails, a comment will be posted and showing the output of terraform validate with all syntax errors.
* It is recommended to run terraform validate before applying any changes.
	
```
Terraform validate 
```

### Terraform Build
***There are three steps to build infrastructure with Terraform:***
1. Initialize the Terraform configuration directory using terraform init
2. Create an execution plan using terraform plan
3. Create or modify infrastructure using terraform apply

#### Init
* Init is run in the configuration directory. 
* Init will create a hidden directory .terraform and download plugins as needed by the configuration.
* The terraform init command will automatically download and install any provider binaries required by the providers specified in the configuration. 
* If the initialization fails, a comment will be posted on the pull request showing the output of terraform init.

#### Plan
* Before you can create an infrastructure, Terraform needs to generate an execution plan. 
* The command to create or update the execution plan is terraform plan. 
* Terraform plan process starts with the refresh and inspect what is in the existing state file and it compares the existing state file with new desired state configuration file. 
```
terraform plan -out=path 
```
* The path to save the generated execution plan. 
* This plan can then be used with terraform apply to be certain that only the changes shown in this plan are applied. 
```
terraform apply "plan.tf"
```

#### Apply
* The terraform apply command is used to apply the changes in the configuration. 
* The output of the terraform apply shows the execution plan, and describing which actions the terraform will take in order to change the infrastructure to match the configuration.
```
Terraform apply
```

### Terraform state
* When Terraform created the infrastructure it also wrote data into the terraform.tfstate file. 
* The state keeps track of the all managed resources and their associated properties with current values. This state file is extremely important. 
* It is necessary to preserve the state file in a secured place for the entire life cycle of the resources.
* ***We can commit it to the code repository where you store all your terraform configuration files***
* ***But, this is not a recommended way to keep this file in code repository since it contains all the sensitive information of the infrastructure (include passwords)***
* ***The better way is to store it in Azure Storage container
* If you change anything in the terraform configurations (like adding new resources), terraform builds an execution plan that only modifies what is necessary to reach your desired state.
* Terraform uses this state file to create plans and make changes to the infrastructure. 
* Before any terraform operation, Terraform does a refresh to update the state with the real infrastructure.
* The state file contains the below format and listed in JSON format.
* Every state has a monotonically increasing "serial" number. 
* ***If the destination state has a higher serial, Terraform will not allow you to write it since it means that changes have occurred since the state you're attempting to write***
* We can bypass this by passing the command `-force`
```
Version of the state file: "",
Terraform version: "",
Serial number: "",
Lineage: "",
Outputs: {},
Resources: []
```


#### Uses of storage account for state files:
* Azure Storage blobs are automatically locked before any operation that writes to state files. 
* This pattern prevents concurrent state operations, which can cause corruption. 

* Data stored in an Azure blob is encrypted before being persisted. 