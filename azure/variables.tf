variable "location" {
  description = "The Azure region location"
  type        = string
  default     = "East US"
}

variable "machine" {
  description = "Name of the virtual machine."
  type        = string
}

variable "tags" {
  description = "The tags for the project"
  type        = string
}

variable "AdminUser" {
  description = "The admin username for the virtual machines"
  type        = string
}

variable "AdminPass" {
  description = "The admin user's password for the virtual machines"
  type        = string
}
