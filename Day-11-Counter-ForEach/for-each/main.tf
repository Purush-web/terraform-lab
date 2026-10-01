variable "tag" {
    default = ["dev", "prod"]
    type = list(string)
  
}

resource "aws_instance" "name" {
  ami = "ami-0fef201115eefe936"
  instance_type = "t3.micro"
  for_each = toset(var.tag)
  tags = {
    Name = each.value
  }

}