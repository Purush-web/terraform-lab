resource "aws_vpc" "rds-vpc" {
    cidr_block = "10.0.0.0/20"
    tags = { Name = "rds-vp"}
}

resource "aws_subnet" "rds-subnet-1" {
    cidr_block = "10.0.0.0/24"
    vpc_id = aws_vpc.rds-vpc.id
    availability_zone = "us-east-1a"
    tags = { Name = "rds-subnet-1"}
}

resource "aws_subnet" "rds-subnet-2" {
    cidr_block = "10.0.1.0/24"
    vpc_id = aws_vpc.rds-vpc.id
    availability_zone = "us-east-1b"
    tags = { Name = "rds-subnet-2"}
}

resource "aws_internet_gateway" "rds-igw" {
    vpc_id = aws_vpc.rds-vpc.id
    tags = { Name = "rds-igw" }
}

resource "aws_route_table" "rds-rt" {
    vpc_id=aws_vpc.rds-vpc.id
    route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.rds-igw.id
    }
    tags = { Name = "rds-rt" }
}

resource "aws_route_table_association" "rds-sn-assoc-1" {
    subnet_id = aws_subnet.rds-subnet-1.id
    route_table_id = aws_route_table.rds-rt.id
}

resource "aws_route_table_association" "rds-sn-assoc-2" {
    subnet_id = aws_subnet.rds-subnet-2.id
    route_table_id = aws_route_table.rds-rt.id
}

resource "aws_security_group" "rds-sg" {
    name = "rds-sg"
    description = "Security group for RDS instances allow SSH and MySQL access"
    vpc_id = aws_vpc.rds-vpc.id
    tags = { Name = "rds-sg" }

    ingress {
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_db_subnet_group" "rds-sng" {
    name = "rds-sng"
    subnet_ids = [aws_subnet.rds-subnet-1.id, aws_subnet.rds-subnet-2.id]
    tags = { Name = "rds-sng" }
}

resource "aws_db_instance" "rds-instance" {
    allocated_storage = 20
    db_name = "appdb"
    engine = "mysql"
    engine_version = "8.0"
    instance_class = "db.t3.micro"
    identifier = "myrdsdb-1"
    username = "admin"
    password = "Admin123!"
    parameter_group_name = "default.mysql8.0"
    db_subnet_group_name = aws_db_subnet_group.rds-sng.name
    vpc_security_group_ids = [aws_security_group.rds-sg.id]
    multi_az = false
    publicly_accessible = false
    skip_final_snapshot = true
    maintenance_window    = "Mon:00:00-Mon:03:00"
    backup_retention_period = 0
}