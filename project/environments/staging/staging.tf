variable "environment" {

}

variable "region" {

}

variable "ami_id" {

}

variable "start" {
}

variable "end" {
}

provider "aws" {
    region = var.region
    version = "~>2.7"
}

module "infrastructure" {
    source = "../../modules/infrastructure"
    environment = var.environment
    region = var.region
    ami_id = var.ami_id
    start = var.start
    end = var.end
}