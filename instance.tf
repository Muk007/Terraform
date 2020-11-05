#data "aws_vpc" "my_vpc" {
#        default = true
#}

resource "aws_key_pair" "mykey" {
  key_name   = "mykey"
  public_key = "${file(var.PUBLIC_KEY)}"
}

resource "aws_instance" "web-server" {
  count                  = "${var.COUNT}"
  ami                    = "${var.ami}"
  instance_type          = "t2.micro"
  key_name               = "${aws_key_pair.mykey.key_name}"
  subnet_id              = "${aws_subnet.subnet_public.id}"
  vpc_security_group_ids = [aws_security_group.allow_sec.id]
  user_data = "${file("shell.sh")}"
  tags = {
    count = "${var.COUNT}"
    Name  = "Terra_Instance_${count.index}"
    #Name = "WEB-Server"
  }
   
  provisioner "local-exec" {
     command = "echo ${self.private_ip} >> web_private_ip_list.txt"
  }

  connection {
    type = "ssh"
    host = self.private_ip
    user = "ubuntu"
    private_key = file(/home/mukesh/Terraform/mykey) 
  }
  
  provisioner "file" {
        source = "/home/mukesh/Terraform/shell.sh"
        destination = "/tmp"
  }


}

resource "aws_instance" "db-server" {
# count                  = "${var.COUNT}"
  ami                    = "${var.ami}"
  instance_type          = "t2.micro"
  key_name               = "${aws_key_pair.mykey.key_name}"
  subnet_id              = "${aws_subnet.subnet_private.id}"
  vpc_security_group_ids = [aws_security_group.db_allow_sec.id]
  tags = {
    count = "${var.COUNT}"
    #Name  = "Db_Terra_Instance_${count.index}"
    Name = "DB"
  }
  provisioner "local-exec" {
    command = "echo ${self.private_ip} >> db_private_ip_list.txt"
  }
}

#Creating an extra volume and attaching it to the db-server.

resource "aws_ebs_volume" "ebs_for_db" {
	availability_zone = "${var.availability_zone_names[1]}"
	size = 20
	type = "gp2"
	tags = {
		Name = "ebs_for_db"
		Server_type = "Database"
	}
}

resource "aws_volume_attachment" "ebs_attach" {
	device_name = "/dev/xvdh"
	volume_id = "${aws_ebs_volume.ebs_for_db.id}"
	instance_id = "${aws_instance.db-server.id}"
}
