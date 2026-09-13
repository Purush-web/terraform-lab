variable "vpc_cidr" {
    default = "10.0.0.0/24"
    type = string
    description = "CIDR block for the VPC"  
}

variable "subnet_cidr" {
    default = "10.0.0.0/28"
    type = string
    description = "CIDR block for the Subnet"
}