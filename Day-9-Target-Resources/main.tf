provider "aws" {}

resource "aws_vpc" "vpc-1" {
    cidr_block = "10.0.0.0/24"
    tags = {Name = "newvpc"}
}

resource "aws_instance" "name" {
    instance_type = "t3.micro"
    ami = "ami-0fef201115eefe936"
    tags = {Name = "tempserver"}
}

#command to target only vpc creation
#terraform plan -target=aws_vpc.vpc-1