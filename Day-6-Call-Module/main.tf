module "ec2" {
    source = "../Day-6-Modules"
    ami = "ami-0fef201115eefe936"
    instance_type = "t3.micro"
    instance_name = "server-1"
}