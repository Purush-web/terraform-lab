#Call module
module "network" {
  source = "./Modules/Network"
  vpc_cidr = "10.0.0.0/16"
  vpc_name = "VPC-1"
  subnet_cidr = "10.0.0.0/24"
  subnet_az = "us-east-1a"
  subnet_name = "MySubnet1"
}

module "compute" {
  source = "./Modules/Compute"
  instance_type = "t3.micro"
  ami = "ami-0fef201115eefe936"
  subnet_id = module.network.subnet_id
  instance_name = "Server-1"
}

