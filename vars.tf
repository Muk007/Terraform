variable "aws_region" {
  default = "us-east-1"
}
variable "ami" {
  default = "ami-0817d428a6fb68645"
}
variable "PUBLIC_KEY" {
  type    = string
  default = "mykey.pub"
}
variable "PRIVATE_KEY" {
  default = "mykey"
}
variable "USERNAME" {
  default = "ubuntu"
}
variable "COUNT" {
  type    = number
  default = 3
}

variable "availability_zone_names" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b"]
}

