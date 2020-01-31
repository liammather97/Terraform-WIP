output "main_subnet_id" {
  value = aws_subnet.main.id
  description = "Id for the main subnet within main VPC"
}