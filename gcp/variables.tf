variable "project_id" {
  description = "Name of the project GCP."
  type        = string
}

variable "machine" {
  description = "Name of the virtual machine."
  type        = string
}

variable "machine_type" {
  description = "Type of the virtual machine."
  type        = string
}

variable "region" {
  description = "The GCP region where resources will be deployed."
  type        = string
}

variable "image" {
  description = "Disk Image used."
  type        = string
  default     = "debian-cloud/debian-10"
}

variable "disk_size_gb" {
  description = "Instance disk size"
  type        = number
  default     = 30
}
