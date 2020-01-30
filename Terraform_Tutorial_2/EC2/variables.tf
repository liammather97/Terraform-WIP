variable "ubuntu-ami" {
    type = string
    description = "ami for a ubuntu instance"
    default = "ami-0be057a22c63962cb"
}

variable "instance-type" {
    type = string
    description = "The instance type"
    default = "t2.micro"
}

variable "pem-key" {
    type = string
    description = "The key pair"
    default = "app1"
}

variable "subnet_id" {
    description = ""
}

variable "vpc_security_group_ids" {
    type = string
}

variable "tags" {
    type = string

}

variable "associate_public_ip_address" {
    type = string
    default = true
}