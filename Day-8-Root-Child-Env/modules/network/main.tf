resource "aws_vpc" "main" {
    cidr_block = var.vpc_cidr
    tags = {Name = "main-vpc"}
}

resource "aws_subnet" "subnet-1" {
    vpc_id = aws_vpc.main.id
    cidr_block = var.subnet_cidr
}

output "subnet_id" {
    value = aws_subnet.subnet-1.id
}