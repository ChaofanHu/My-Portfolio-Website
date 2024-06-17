data "aws_ami" "my_website_ami" {
    most_recent = true
    owners = ["amazon"]
    filter {
        name = "name"
        values = ["amzn2-ami-kernel-*-x86_64-gp2"]
    }
    filter {
        name = "virtualization-type"
        values = ["hvm"]
    }
}

resource "aws_instance" "my_website_instance" {
    instance_type = var.instance_type
    ami = data.aws_ami.my_website_ami.id
    subnet_id = var.subnet_id
    vpc_security_group_ids = var.vpc_security_group_ids
    availability_zone = var.availability_zone

    associate_public_ip_address = true
    
    user_data = file("entrypoint.sh")

    tags = {
        Name = "${var.env_prefix}-website-instance"
    }
}