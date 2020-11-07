# Azure Infrastructure Operations Project: Deploying a scalable IaaS web server in Azure

### Introduction
For this project, you will write a Packer template and a Terraform template to deploy a customizable, scalable web server in Azure.

### Dependencies
1. Create an [Azure Account](https://portal.azure.com) 
2. Install the [Azure command line interface](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest)
3. Install [Packer](https://www.packer.io/downloads)
4. Install [Terraform](https://www.terraform.io/downloads.html)

### Instructions
1. Create a new subscription on Azure Portal (if you don't have one)
2. Add app registration for Packer and Terraform
3. Create a credential for Packer
3. Export to environment your credential for Packer (ARM_CLIENT_ID, ARM_CLIENT_SECRET,) and subscription id (ARM_SUBSCRIPTION_ID)
4. Run command `packer build server.json` to create Ubuntu image
5. Export to environment tenant id (TF_VAR_tenant_id) and subscription id (TF_VAR_subscription_id)
6. Run command `terraform plan` and enter necessary variables:
	prefix - the prefix for all resources names
	location - location, where your resources will be deployed
	user - user name for virtual machines 
	password - password for virtual machines. 
	instances - number of virtual machines that will be created
7. Run `terraform apply`


### Output
Customizable and scalable web server in Azure.

