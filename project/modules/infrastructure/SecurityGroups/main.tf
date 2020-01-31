resource "aws_security_group" "main" {
    name = var.name
    description = "allow ssh connection"
    vpc_id = var.vpc_id

    dynamic "ingress" {
        iterator = port
        for_each = var.ingress_ports
        content {
            from_port = port.value
            protocol = "tcp"
            to_port = port.value
            cidr_blocks = var.open_internet
        }
    }

    egress {
        from_port = var.outbound_port
            protocol = "-1"
            to_port = var.outbound_port
            cidr_blocks = var.open_internet
    }
}