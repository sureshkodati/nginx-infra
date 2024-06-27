variable "project_id" {
  type        = string
  default     = ""
  description = "Project Name"
}

variable "my_region" {
  type        = string
  default     = ""
  description = "Region Name"
}

variable "my_zone" {
  type        = string
  default     = ""
  description = "Region Name"
}

variable "bucket_name" {
  type        = string
  default     = ""
  description = "GCS Bucket Name"
}

variable "vm_name" {
  type        = string
  default     = ""
  description = "GCS Bucket Name"
}

variable "backend_region" {
  type        = string
  default     = ""
  description = "State File Region Name"
}

variable "my_vpc" {
  type        = string
  default     = ""
  description = "VPC Network Name"
}

variable "my_subnet" {
  type        = string
  default     = ""
  description = "VPC Network Name"
}

variable "cidr_range" {
  type        = string
  default     = "10.1.0.0/16"
  description = "CIDR Range"
}
variable "machine_type" {
  type        = string
  default     = ""
  description = "VPC Network Name"
}

variable "linux_server_image" {
  type        = string
  default     = ""
  description = "IIS server Name"
}

variable "service_account_roles" {
  type        = set(string)
  default     = ["roles/compute.imageUser", "roles/compute.networkUser", ]
  description = "Sercive Acount Roles"
}


variable "env" {
  type        = string
  default     = ""
  description = "Environment type"
}

variable "allowed_ports" {
  type    = list(number)
  default = [80, 443, 8080, 3389]
}