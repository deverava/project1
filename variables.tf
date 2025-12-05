# Test change to trigger CI
# trigger pipeline test
variable "location" {
  type        = string
  description = "Azure region for the deployment"
  default     = "westus2"
}

variable "project_owner" {
  type        = string
  description = "Owner tag for all resources"
  default     = "Vijay"
}

variable "environment" {
  type        = string
  description = "Environment tag"
  default     = "PoC"
}

variable "vm_admin_username" {
  type        = string
  description = "Admin username for the VM"
  default     = "vmadmin"
}

variable "vm_admin_password" {
  type        = string
  description = "Admin password for the VM"
  sensitive   = true
}

