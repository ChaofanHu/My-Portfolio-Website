provider "aws"{
    region = "eu-central-1"
    access_key = var.access_key
    secret_key = var.secret_key
}

terraform {
    backend "s3" {
        bucket = "chaofan-bucket"
        // The Path to the state file
        key = "my-website/terraform.tfstate"
        region = "eu-central-1"
    }
}

resource "aws_vpc" "my_website" {
    cidr_block = var.vpc_cidr_block
    tags = {
        Name = "${var.env_prefix}-vpc"
    }
}

module "my_website_subnet" {
    source = "./modules/subnet"
    vpc_id = aws_vpc.my_website.id
    subnet_cidr_block = var.subnet_cidr_block
    availability_zone = var.availability_zone
    env_prefix = var.env_prefix
}

module "my_website_instance" {
    source = "./modules/webserver"
    vpc_id = aws_vpc.my_website.id
    subnet_id = module.my_website_subnet.subnet.id
    availability_zone = var.availability_zone
    env_prefix = var.env_prefix
    my_ip = var.my_ip
    aws_ami = var.aws_ami
    instance_type = var.instance_type
    public_key_location = var.public_key_location
}

