variable "vpc_cidr" {
    default = ""
    type   = string
    description = "CIDR block for the VPC"
}

variable "subnet_cidr" {
    default = ""
    type   = string
    description = "CIDR block for the subnet"
}