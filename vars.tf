variable "prefix" {
  description = "The prefix which should be used for all resources in this example"
}

variable "location" {
  description = "The Azure Region in which all resources in this example should be created."
}

variable "user" {
  description = "The username for authentication"
}

variable "password" {
  description = "The password for authentication"
}

variable "instances"{
	description = "The number of instances that will be created"
}

variable "tenant_id" {
  description = ""
}

variable "subscription_id" {
  description = ""
}

