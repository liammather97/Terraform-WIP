provider "aws" {
  region        = "eu-west-2"
}

resource "aws_vpc" "main" {
    cidr_block = "10.0.0.0/16"
    enable_dns_hostnames = true
    availability_zone = "eu-west-2a"

    tags {
        name = "main-vpc"
    }
}

resource "aws_internet_gateway" "web" {
    vpc_id = "${aws_vpc.web.id}"
}

# PUBLIC 

resource "aws_subnet" "main" {
    vpc_id = "${aws_vpc.main.id}"
    cidr_block = "10.0.0.0/24"
    availability_zone = "eu-west-2a"
    map_public_ip_on_launch = true

    tags {
        name = "Main"
    }
}

resource "aws_route_table" "main" {
    vpc_id = "${aws_vpc.main.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.web.id}"
    }

    tags {
        name = "Main"
    }
}

resource "aws_route_table_association" "main" {
    subnet_id = "${aws_subnet.main.id}"
    route_table_id = "${aws_route_table.main.id}"
}  availability_zone = "eu-west-2a"
resource "aws_subnet" "private" {
    vpc_id = "${aws_vpc.private.id}"
    cidr_block = "10.0.0.0/24"
    availability_zone = "eu-west-2a"

    tags {
        name = "Private"
    }
}

resource "aws_route_table" "private" {
    vpc_id = "${aws_vpc.main.id}"

    route {
        cidr_block = "0.0.0.0/0"
        instance_id = "${aws_instance.nat.id}"

    }

    tags {
        name = "Private"
    }
}

resource "aws_db_parameter_group" "mysql-parameters" {
    name   = "mysql-parameters"
    family = "mysql5.7"
    description = "MySQL parameter group"

    parameter {
        name  = "max_allowed_packet"
        value = "16777216"
    }
}

resource "aws_db_subnet_group" "mysql-subnet" {
    name = "mysql-suesource "aws_db_subnet_group" "mysql-subnet" {
    name = "mysql-subnet"
    description = "RDS subnet group"
    subnet_ids = ["${aws_subnet.private.id}"]ty_group" "allow-sql" {
    vpc_id = "${aws_vpc.main.id}"
    name = "allow-sql"
    description = "allow-sql"

    ingress {
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        security_groups = ["${aws_security_group.example.id}"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        self = true
    }

    tags {
        Name = "allow-sql"
    }
}

resource "aws_db_instance" "default" {
  allocated_storage       = 20
  # max allocated storage is used for auto scaling
  max_allocated_storage   = 50
  storage_type            = "gp2"
  engine                  = "mysql"
  engine_version          = "5.7"
  instance_class          = "db.t2.micro"
  identifier              = "mydb"
  name                    = "mydb"
  username                = "yeet"
  password                = "yeetyeet"
  db_subnet_group_name    = "[${aws_db_subnet_group.mysql_subnet.name}]"
  parameter_group_name    = "mysql-parameters"
  multi_az                = "false"
  # set this to true to have high availability - 2 instnaces synchronized with eachother
  vpc_security_group_ids  = "[${aws_security_group.allow-sql.id}]"
  backup_retention_period = 30
  # how long to keep back ups(days)
  availability_zone = "${aws_subnet.main-private-1.availability_zone}"
  # preferred AZ
}

# NAT GATEWAY
# INGRESS AND EGRESS OF VPC
