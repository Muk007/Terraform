output "web-server_public_ip" {
  	value = "${aws_instance.web-server[*].public_ip}"
}

#output "db-server_public_ip" {
#	value = "${aws_instance.db-server[*].public_ip}"
#}

output "web-server_private_ip" {
	value = "${aws_instance.web-server[*].private_ip}"
}

#output "db-server_private_ip" {
#	value = "${aws_instance.db-server[*].private_ip}"
#}

#aws_instance.terra-instance[*].private_ip
