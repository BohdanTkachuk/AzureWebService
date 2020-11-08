variable "prefix" {
  description = "The prefix which should be used for all resources in this example"
  default = "newProject"
}

variable "location" {
  description = "The Azure Region in which all resources in this example should be created."
  default = "germanywestcentral"
}

variable "user" {
  description = "The username for authentication"
  default = "newUser"
}

variable "password" {
  description = "The password for authentication"
  default = "P@ssword"
}

variable "instances"{
	description = "The number of instances that will be created"
	default = 2
	validation {
		condition = var.instances < 6	
		error_message = "The number of instances must be smaller or equal than 5."
	}
}

variable "tenant_id" {
  description = ""
}

variable "subscription_id" {
  description = ""
}

