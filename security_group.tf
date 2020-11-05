resource "aws_security_group" "allow_sec" {
  vpc_id = "${aws_vpc.myvpc.id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }
  tags = {
  	Name = "sec-group-for-web"
  }

}


resource "aws_security_group" "db_allow_sec" {
  vpc_id = "${aws_vpc.myvpc.id}"

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [aws_subnet.subnet_public.cidr_block]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [aws_subnet.subnet_public.cidr_block]

  }
  tags = {
  	Name = "sec-group-for-db"
  }
}
