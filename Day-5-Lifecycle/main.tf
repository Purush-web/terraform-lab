
resource "aws_instance" "name" {
    ami                    = "ami-0bd3fbcdc633a1b1a" #Amazon 202
    instance_type          = "t3.micro"
    tags = {
        Name = "my-instance"
    }
   
   lifecycle {
    create_before_destroy = true
    prevent_destroy = true
    ignore_changes = [tags] #not overriding the tags if we change the tags in the code. It will not destroy the instance and create a new one. It will just ignore the changes in the tags.
  }
}