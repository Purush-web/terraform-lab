variable "tag" {
    default = ["dev", "prod"]
    type = list(string)
  
}

resource "aws_instance" "name" {
  ami = "ami-0fef201115eefe936"
  instance_type = "t3.micro"
  count = length(var.tag)
  tags = {
    Name = var.tag[count.index]
  }

}