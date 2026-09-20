#VPC variables
variable "vpc_cidr" {
    default     = ""
    type        = string
}

variable "vpc_name" {
    default     = ""
    type        = string
}
#Subnet variables
variable "subnet_cidr" {
    default     = ""
    type        = string
}

variable "subnet_az" {
    default     = ""
    type        = string
}

variable "subnet_name" {
    default     = ""
    type        = string
}

