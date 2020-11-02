resource "aws_vpc" "myvpc" {
        cidr_block = "10.0.0.0/16"
        instance_tenancy = "default"
        enable_dns_hostnames = "true"
        enable_dns_support = "true"
        enable_classiclink = "false"
        tags = {
                Name = "My_Terra_VPC"
        }
}

resource "aws_internet_gateway" "IGW" {
        vpc_id = "${aws_vpc.myvpc.id}"
        tags = {
            Name = "Terra-IGW"
        }
}

resource "aws_route_table"  "route-1" {
        vpc_id = "${aws_vpc.myvpc.id}"
	route {
		cidr_block = "0.0.0.0/0"
		gateway_id = "${aws_internet_gateway.IGW.id}"
	}
	tags = {
                Name = "public route"
        }
}

resource "aws_route_table"  "route-2" {
        vpc_id = "${aws_vpc.myvpc.id}"
        tags = {
                Name = "private route"
        }
}

resource "aws_subnet" "subnet_1" {
        vpc_id = "${aws_vpc.myvpc.id}"
        cidr_block = "10.0.1.0/28"
	map_public_ip_on_launch = "true"
	availability_zone = "${var.availability_zone_names[0]}"
}

resource "aws_subnet" "subnet_2" {
        vpc_id = "${aws_vpc.myvpc.id}"
        cidr_block = "10.0.2.16/28"
        availability_zone = "${var.availability_zone_names[1]}"
}

resource "aws_route_table_association" "a" {
        subnet_id = "${aws_subnet.subnet_1.id}"
        route_table_id = "${aws_route_table.route-1.id}"
}

resource "aws_route_table_association" "b" {
        gateway_id = "${aws_internet_gateway.IGW.id}"
        route_table_id = "${aws_route_table.route-2.id}"
}

