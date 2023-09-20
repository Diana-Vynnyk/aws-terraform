variable "region" {
  description = "AWS Region for instance "
  type        = string
  default     = "ca-central-1"
}

variable "instance_type" {
  description = "Instance Type"
  type        = string
  default     = "t2.micro"
}

variable "allow_ports" {
  description = "List of ports to open for server"
  type        = list(any)
  default     = ["80", "443", "22", "8080"]
}

variable "enable_detailed_monitoring" {
  description = "To enable monitoring change value to true (additional costs)"
  type        = bool
  default     = false
}

variable "common_tags" {
  description = "Common Tags to apply to all resources"
  type        = map(any)
  default = {
    Owner       = "Diana Vynnyk"
    Project     = "WebServer"
    Environment = "development"
  }
}
