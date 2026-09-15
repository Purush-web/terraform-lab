resource "aws_vpc" "Tf_VPC" {
  cidr_block = var.vpc_cidr
  tags       = { Name = "Tf_VPC" }
}

resource "aws_subnet" "Tf_Subnet_Pub" {
  cidr_block = var.public_subnet_cidr
  tags       = { Name = "Tf_Subnet_Pub" }
  vpc_id     = aws_vpc.Tf_VPC.id
}

resource "aws_subnet" "Tf_Subnet_Pvt" {
  cidr_block = var.private_subnet_cidr
  tags       = { Name = "Tf_Subnet_Pvt" }
  vpc_id     = aws_vpc.Tf_VPC.id
}

resource "aws_internet_gateway" "Tf_IGW" {
  vpc_id = aws_vpc.Tf_VPC.id
  tags   = { Name = "Tf_IGW" }
}

resource "aws_route_table" "TF_RT_pub" {
  vpc_id = aws_vpc.Tf_VPC.id
  tags   = { Name = "TF_RT_pub" }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Tf_IGW.id
  }
}

resource "aws_route_table" "TF_RT_pvt" {
  vpc_id = aws_vpc.Tf_VPC.id
  tags   = { Name = "TF_RT_pvt" }
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.Tf_NAT-gw.id
  }
}

resource "aws_route_table_association" "Tf_RT_assoc_pub" {
  subnet_id      = aws_subnet.Tf_Subnet_Pub.id
  route_table_id = aws_route_table.TF_RT_pub.id
}

resource "aws_route_table_association" "Tf_RT_assoc_pvt" {
  subnet_id      = aws_subnet.Tf_Subnet_Pvt.id
  route_table_id = aws_route_table.TF_RT_pvt.id
}

resource "aws_security_group" "Tf_SG" {
  name   = "Tf_SG"
  vpc_id = aws_vpc.Tf_VPC.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_nat_gateway" "Tf_NAT-gw" {
  subnet_id     = aws_subnet.Tf_Subnet_Pub.id
  tags          = { Name = "Tf_NAT-gw" }
  allocation_id = aws_eip.Tf_EIP.id
}

resource "aws_eip" "Tf_EIP" {
  domain = "vpc"
  tags   = { Name = "Tf_EIP" }
}

resource "aws_instance" "Tf_EC2" {
  ami                    = "ami-0e34b50e714a297f1"
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.Tf_Subnet_Pub.id
  vpc_security_group_ids = [aws_security_group.Tf_SG.id]
  tags                   = { Name = "Tf_EC2" }
}
