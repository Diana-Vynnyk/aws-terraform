variable "env" {
  description = "Which env"
  default     = "prod"
}

variable "prod_onwer" {
  default = "Diana Vynnyk"
}

variable "noprod_owner" {
  default = "Vynnyk Diana - dev env"
}

variable "ec2_size" {
  default = {
    "prod"    = "t2.micro"
    "dev"     = "t2.nano"
    "staging" = "t2.small"
  }
}

variable "allow_port_list" {
  default = {
    "prod" = ["80", "443"]
    "dev"  = ["80", "443", "8080", "22"]
  }
}
