resource "aws_vpc" "myvpc" {
        cidr_block = "10.0.0.0/16"
        instance_tenancy = "default"
        tags = {
                Name = "My_Terra_VPC"
        }
}

resource "aws_subnet" "subnet_public" {
        vpc_id = "${aws_vpc.myvpc.id}"
        cidr_block = "10.0.1.0/28"
	map_public_ip_on_launch = "true"
	availability_zone = "${var.availability_zone_names[0]}"
	tags = {
		Name = "Subnet_public"
	}
}

resource "aws_subnet" "subnet_private" {
        vpc_id = "${aws_vpc.myvpc.id}"
        cidr_block = "10.0.2.0/28"
        availability_zone = "${var.availability_zone_names[1]}"
	tags = {
		Name = "Subnet_private"
	}
}

resource "aws_internet_gateway" "IGW" {
        vpc_id = "${aws_vpc.myvpc.id}"
        tags = {
            Name = "Terra-IGW"
        }
}

resource "aws_eip" "nat" {
	vpc = "true"
	tags = {
		Name = "natGW"
	}
}

resource "aws_nat_gateway" "gw" {
	allocation_id = "${aws_eip.nat.id}"    
	subnet_id = "${aws_subnet.subnet_public.id}" 
}

resource "aws_route_table"  "public_route" {
        vpc_id = "${aws_vpc.myvpc.id}"
	route {
		cidr_block = "0.0.0.0/0"
		gateway_id = "${aws_internet_gateway.IGW.id}"
	}
	tags = {
                Name = "public route"
        }
}

resource "aws_route_table"  "private_route" {
        vpc_id = "${aws_vpc.myvpc.id}"
	route {
		cidr_block = "0.0.0.0/0"	
		nat_gateway_id = "${aws_nat_gateway.gw.id}"
	}
	tags = {
                Name = "private route"
        }
}

resource "aws_route_table_association" "private_assocation" {
        subnet_id = "${aws_subnet.subnet_private.id}"
        route_table_id = "${aws_route_table.private_route.id}"
}

resource "aws_route_table_association" "public_association" {
        subnet_id = "${aws_subnet.subnet_public.id}"
        route_table_id = "${aws_route_table.public_route.id}"
}

