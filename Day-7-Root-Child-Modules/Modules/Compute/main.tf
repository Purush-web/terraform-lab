#EC2 Module
resource "aws_instance" "Server-1" {
  ami = var.ami
  instance_type = var.instance_type
  subnet_id = var.subnet_id
  tags = { Name = var.instance_name }
}