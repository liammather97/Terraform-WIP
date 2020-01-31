resource "aws_subnet" "main" {
    vpc_id = "${var.vpc_id}"
    cidr_block = "10.0.0.0/24"
}