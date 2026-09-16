resource "aws_vpc" "main-vpc" {
    cidr_block = "10.0.0.0/24"
    tags = {
        Name = "main-vpc"
       }
}

resource "aws_subnet" "main-subnet" {
    cidr_block = "10.0.0.0/28"
    vpc_id = aws_vpc.main-vpc.id
    tags = {
        Name = "main-subnet"
    }

}

resource "aws_instance" "main-instance" {
    ami = "ami-0e34b50e714a297f1"
    instance_type = "t3.micro"
    subnet_id = aws_subnet.main-subnet.id
    tags = {
        Name = "main-instance"
    }
}