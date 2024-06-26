resource "aws_subnet" "my_website_subnet" {
    vpc_id = var.vpc_id
    cidr_block = var.subnet_cidr_block
    availability_zone = var.availability_zone
    tags = {
        Name = "${var.env_prefix}-subnet-1"
    }
}

resource "aws_internet_gateway" "my_website_igw" {
    vpc_id = var.vpc_id
    tags = {
        Name = "${var.env_prefix}-igw"
    }
}

resource "aws_route_table" "my_website_route_table" {
    vpc_id = var.vpc_id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.my_website_igw.id
    }
    tags = {
        Name = "${var.env_prefix}-route-table"
    }
}

resource "aws_route_table_association" "a-rtb-subnet" {
    subnet_id = aws_subnet.my_website_subnet.id
    route_table_id = aws_route_table.my_website_route_table.id
}
