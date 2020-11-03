output "ip" {
  value = "${aws_instance.terra-instance-1.*.public_ip}"
}

