output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnetA_id" {
  value = aws_subnet.publicA.id
}