variable "resource_group_name" {
  description = "Pre-provisioned resource group assigned for this lab."
  type        = string
}

variable "inbound_ports" {
  description = "List of inbound ports to allow on the network security group."
  type        = list(number)
  default     = [22, 80, 443, 8080]
}

variable "location" {
  description = "Location for the resources."
  type        = string
}

variable "linux_names" {
  type        = set(string)
  description = "List of Linux VM names to be created."
  default     = ["linux-vm-1", "linux-vm-2"]
}