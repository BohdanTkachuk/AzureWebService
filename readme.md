# Azure Infrastructure Operations Project: Deploying a scalable IaaS web server in Azure

### Introduction
For this project, you will use a Packer template and a Terraform template to deploy a customizable, scalable web server in Azure Web server will include following components:
1. Resource group. 
2. Virtual network.
3. Virtual subnet.
4. Network interface for each virtual machine.
5. Public IP.
6. Network Security Group which allow all traffic within virtual network and deny all direct traffic from the Internet.
7. Load Balancer with Backend Adress Pool and Health Probe.
8. Custom Ubuntu image that will be created using Packer.
9. Customizable number of virtual machines with custom Ubuntu image.
10. Managed disk for each virtual machine.


### Dependencies
1. Create an [Azure Account](https://portal.azure.com) 
2. Install the [Azure command line interface](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest)
3. Install [Packer](https://www.packer.io/downloads)
4. Install [Terraform](https://www.terraform.io/downloads.html)

### Instructions
1. Create a new subscription on Azure Portal (if you don't have one).
2. Add app registration for Packer and Terraform.
3. Create a credential for Packer.
3. Export to environment your credential for Packer (ARM_CLIENT_ID, ARM_CLIENT_SECRET,) and subscription id (ARM_SUBSCRIPTION_ID) running `export = ARM_CLIENT_ID = "your client ID"`, `export = ARM_CLIENT_SECRET = "your client secret"` and `export = ARM_SUBSCRIPTION_ID = "your subscription id"`, where instead of `"your client id"`, `"your client secret"` and `"your subscription id"`  put your parameters respectively.
4. Run command `packer build server.json` to create Ubuntu image, make sure that you use existing resource group. The result of command will be a new image resource, which will be used in following steps.
5. Export to environment tenant id (TF_VAR_tenant_id) and subscription id (TF_VAR_subscription_id) running `export TF_VAR_subscriptiont_id = "your subscription id"`and `export TF_VAR_tenant_id = "your tenant id"` where `"your tenant id"` and `"your tenant id"` your parameters.
6. Run command `terraform plan`. This command create a plan for future deployment and will show the list of resources, which will be created. The file `vars.tf` consist all customizable variables which have a default value. You can optionally change variables simply modifying command `terraform plan -var 'variable=value'`, where `variable` is name of variable which you want to change and `your_value` is the custom value, which you want to set up for correspondent variable. The list of available variables below:
	-prefix - the prefix for all resources names.
	-location - location, where your resources will be deployed.
	-user - user name for virtual machines.
	-password - password for virtual machines. 
	-instances - number of virtual machines that will be created.
7. Run `terraform apply`. This command will deploy all resources which have been in output of previous command `terraform plan`..


### Output
Customizable and scalable web server in Azure with numerous of resources.

Screenshots of `terraform apply` output: 
![Alt text](https://i.postimg.cc/65HbQQtk/Screenshot-from-2020-11-08-15-52-16.png)
![Alt text](https://i.postimg.cc/gcHBfD5k/Screenshot-from-2020-11-08-15-52-22.png)
![Alt text](https://i.postimg.cc/520G5Cs9/Screenshot-from-2020-11-08-15-52-25.png)
![Alt text](https://i.postimg.cc/pd564tNg/Screenshot-from-2020-11-08-15-52-29.png)
![Alt text](https://i.postimg.cc/MZ7hzxcw/Screenshot-from-2020-11-08-15-52-34.png)
![Alt text](https://i.postimg.cc/sxsHMQBr/Screenshot-from-2020-11-08-15-52-38.png)
![Alt text](https://i.postimg.cc/G2051Sd9/Screenshot-from-2020-11-08-15-52-43.png)
![Alt text](https://i.postimg.cc/L537DBd5/Screenshot-from-2020-11-08-15-52-53.png)
![Alt text](https://i.postimg.cc/qR8ZBXvw/Screenshot-from-2020-11-08-15-53-05.png)
![Alt text](https://i.postimg.cc/Y0RnYrgm/Screenshot-from-2020-11-08-15-53-14.png)
![Alt text](https://i.postimg.cc/nckbGZZ2/Screenshot-from-2020-11-08-15-53-18.png)


