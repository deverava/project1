# Region for all resources
variable "location" {
  type        = string
  description = "Azure region for the deployment"
  default     = "westus2"
}

# Common tags
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

# VM admin username
variable "vm_admin_username" {
  type        = string
  description = "Admin username for the VM"
  default     = "vmadmin"
}

# VM admin password (no default – must be provided)
variable "vm_admin_password" {
  type        = string
  description = "Admin password for the VM"
  sensitive   = true
}
