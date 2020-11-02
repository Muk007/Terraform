#data "aws_vpc" "my_vpc" {
#        default = true
#}

resource "aws_vpc" "myvpc" {
	cidr_block = "10.0.0.0/16"
	instance_tenancy = "default"
	tags = {
		Name = "My_Terra_VPC"
	}
}

resource "aws_subnet" "subnet_1" {
        vpc_id = "${aws_vpc.myvpc.id}"
        cidr_block = "10.0.1.0/28"
	availability_zone = "us-east-1a"
}
resource "aws_subnet" "subnet_2" {
	vpc_id = "${aws_vpc.myvpc.id}"
	cidr_block = "10.0.2.16/28"
	availability_zone = "us-east-1b"
}

resource "aws_key_pair" "mykey" {
        key_name = "mykey"
        public_key = "${file("${var.PUBLIC_KEY}")}"
}

resource "aws_instance" "terra-instance-1" {
        count = "${var.COUNT}"
        ami = "${var.ami}"
        instance_type = "t2.micro"
        key_name = "${aws_key_pair.mykey.key_name}"
        subnet_id = "${aws_subnet.subnet_1.id}"
        tags = {
                count = 3
                Name = "Terra_Instance_${count.index}"
        }
#       provisioner "local-exec" {
#               command = "echo ${aws_instance.terra-instance-1[count.index].private_ip} >> private_ip_list.txt"
#       }
}

output "ip" {
        value = "${aws_instance.terra-instance-1.*.public_ip}"
}
