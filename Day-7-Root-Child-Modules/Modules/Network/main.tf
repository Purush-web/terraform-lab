#VPC Module
resource "aws_vpc" "VPC-1" {
  cidr_block = var.vpc_cidr
  tags = { Name = var.vpc_name }
}

#Subnet Module
resource "aws_subnet" "Subnet" {
  vpc_id = aws_vpc.VPC-1.id
  cidr_block = var.subnet_cidr
  availability_zone = var.subnet_az
  tags = { Name = var.subnet_name }
}
