resource "aws_security_group" "allow_sec" {
	name = "allow sec"
	description = "This sec grp allows the traffic in port 22"
	vpc.id = "${aws_vpc.myvpc.id}"

	ingress {
	description = "connection from vpc"
	from_port = 22
	to_port = 22
	protocol = "tcp"
	cidr_blocks = "[aws_vpc.myvpc.cidr_block]"

	egress {
	description = "connection to internet"
	from_port = 0
	to_port = 0
	protocol = "-1"
	cidr_blocks = ["0.0.0.0/0"]

	}
}
