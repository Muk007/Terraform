output "public_ip" {
  value = "${aws_instance.web-server[*].public_ip}"
}

output "private_ip" {
	value = "${aws_instance.web-server[*].private_ip}"
}


#aws_instance.terra-instance[*].private_ip
