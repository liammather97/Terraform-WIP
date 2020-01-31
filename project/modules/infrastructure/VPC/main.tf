resource "aws_vpc" "main" {
    cidr_block = "10.0.0.0/16"
}

resource "aws_internet_gateway" "main" {
    vpc_id = aws_vpc.main.id

    tags = {
        Name = "VPC internet gateway"
    }
}

resource "aws_route_table" "main" {
    vpc_id = aws_vpc.main.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.main.id
    }
}

resource "aws_route_table_association" "main" {
    subnet_id = "${var.main_subnet_id}"
    route_table_id = aws_route_table.main.id

}

