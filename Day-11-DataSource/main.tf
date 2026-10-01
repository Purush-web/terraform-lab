provider "aws" {}

data "aws_subnet" "subname" {
    filter {
        name = "tag:Name"
        values = ["dev"]
    }
}

resource "aws_instance" "dsinstance" {
     ami                    = "ami-0fef201115eefe936" # Amazon Linux 2
     instance_type          = "t3.micro"
     subnet_id              = data.aws_subnet.subname.id
}