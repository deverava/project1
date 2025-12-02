variable "location" {
  type        = string
  description = "Azure region for the deployment"
  default     = "eastus"
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
