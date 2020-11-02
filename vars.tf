variable "aws_region" {
	default = "us-east-2"
}
variable "ami" {
	default = "ami-07efac79022b86107"
}
variable "PUBLIC_KEY" {
	type = string
	default = "mykey.pub"
}
variable "PRIVATE_KEY" {
	default = "mykey"
}
variable "USERNAME" {
	default = "ubuuntu"
}
variable "COUNT" {
	type = number
	default = 3
}

variable "availability_zone_names" {
  	type    = list(string)
  	default = ["us-east-2a", "us-east-2b"]
}

