provider "aws" {
    region = "eu-central-1"
    access_key = var.access_key
    secret_key = var.secret_key
}

terraform {
    backend "s3" {
        bucket = "chaofan-bucket"
        key = "my-website/terraform.tfstate"
        region = "eu-central-1"
    }
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "my-web-vpc"
  cidr = var.cidr_block

  azs             = ["eu-central-1a"]
  public_subnets  = var.public_subnets
  public_subnet_tags = { Name = "${var.env_prefix}-subnet-1"}

  tags = {
    Name = "${var.env_prefix}-vpc"
  }
}

module "vote_service_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "user-service"
  description = "Security group for user-service with custom ports open within VPC, and PostgreSQL publicly open"
  vpc_id      = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 8081
      to_port     = 8081
      protocol    = "tcp"
      description = "User-service ports"
      cidr_blocks = "0.0.0.0/0"
    },
    {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = var.my_ip
    }
  ]

  egress_with_cidr_blocks = [
    {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
}

module "my_website_instance" {
    source = "./modules/webserver"
    vpc_id = module.vpc.vpc_id
    subnet_id = module.vpc.public_subnets[0]
    availability_zone = var.availability_zone
    env_prefix = var.env_prefix
    my_ip = var.my_ip
    instance_type = var.instance_type
    vpc_security_group_ids = [module.vote_service_sg.security_group_id]
}