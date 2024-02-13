variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "vpc_cidr_block" {
  type    = string
  default = "192.168.0.0/16"
}

variable "vpc_name" {
  type    = string
  default = "jenkins-project-vpc"
}

variable "sub_net_name" {
  type    = string
  default = "jenkins-project-sub"
}

variable "sub_net_cidr_block" {
  type    = string
  default = "192.168.0.0/24"
}

variable "sub_net_availability_zone" {
  type    = string
  default = "us-east-1a"
}

variable "internet_gateway_name" {
  type    = string
  default = "jenkins-project-gw"
}

variable "route_table_name" {
  type    = string
  default = "jenkins-project-rt"
}

variable "key_pair_name" {
  type    = string
  default = "devops-projects-key"
}

variable "instance_name" {
  type    = string
  default = "jenkins-project-ec2"
}

variable "instance_ami" {
  type    = string
  default = "ami-053b0d53c279acc90"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}
