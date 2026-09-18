resource "aws_vpc" "vpc5" {
    cidr_block = "10.0.0.0/24"
    tags = { Name = "vpc5"}
    }

resource "aws_subnet" "sn5" {
    vpc_id=aws_vpc.vpc5.id
    cidr_block = "10.0.0.0/28"
    tags = { Name = "sn5"}
    }

resource "aws_instance" "ec5" {
    ami                    = "ami-0bd3fbcdc633a1b1a"
    instance_type          = "t3.micro"
    subnet_id              = aws_subnet.sn5.id
    tags = { Name = "ec5"}
    }