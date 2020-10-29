resource "aws_key_pair" "mykey" {
	key_name = "mykey"
	public_key = "${file("${var.PUBLIC_KEY}")}"
}

resource "aws_instance" "terra-instance-1" {
	count = "${var.COUNT}"
	ami = "${var.ami}"
	instance_type = "t2.micro"
	key_name = "${aws_key_pair.mykey.key_name}"
	tags = {
		count = 3
		Name = "Terra_Instance_${count.index}"
	}
#	provisioner "local-exec" {
#		command = "echo ${aws_instance.terra-instance-1[count.index].private_ip} >> private_ip_list.txt"
#	}
}

output "ip" {
	value = "${aws_instance.terra-instance-1.*.public_ip}"
}
