resource "aws_security_group" "my_website_sg" {
    name = "mywebsite-sg"
    vpc_id = var.vpc_id
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = [var.my_ip]
    }
    ingress {
        from_port = 8080
        to_port = 8081
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 3000
        to_port = 3000
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = "${var.env_prefix}-sg"
    }
}

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

resource "aws_key_pair" "my_website_key_pair" {
    key_name = "server-key"
    public_key = file(var.public_key_location)
}

resource "aws_instance" "my_website_instance" {
    instance_type = var.instance_type
    ami = data.aws_ami.my_website_ami.id
    subnet_id = var.subnet_id
    vpc_security_group_ids = [aws_security_group.my_website_sg.id]
    availability_zone = var.availability_zone

    associate_public_ip_address = true
    // reference from key pair name in AWS EC2
    key_name = "server-key"

    user_data = file("entrypoint.sh")

    # connection {
    #     type = "ssh"
    #     host = self.public_ip
    #     user = "ec2-user"
    #     private_key = file(var.public_key_location)
    # }

    # provisioner "file" {
    #     source = "entrypoint.sh"
    #     destination = "/home/ec2-user/entrypoint.sh"
    # }

    # provisioner "remote-exec" {
    #     script = file("entrypoint.sh")
    # }

    # provisioner "local-exec"{
    #     command = "echo \"Hello, World!\" > index.html"
    # }

    tags = {
        Name = "${var.env_prefix}-website-instance"
    }
}