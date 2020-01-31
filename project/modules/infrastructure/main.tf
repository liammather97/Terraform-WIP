module "vpc" {
    source = "./VPC"

    environment = var.environment
    region = var.region
    main_subnet_id = module.subnets.main_subnet_id
}

module "asg" {
    source = "./ASG"

    environment = var.environment
    region = var.region
    ami_id = var.ami_id
    main_subnet_id = module.subnets.main_subnet_id
    start = var.start
    end = var.end
}

module "subnets" {
    source = "./subnets"

    environment = var.environment
    region = var.region
    vpc_id = module.vpc.vpc_id
}

module "SecurityGroups" {
    source = "./SecurityGroups"

    vpc_id = module.vpc.vpc_id
}