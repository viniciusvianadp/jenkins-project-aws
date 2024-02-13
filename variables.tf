variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "vpc_cidr_block" {
  type    = string
  default = "10.0.0.0/16"
}

variable "vpc_name" {
  type    = string
  default = "jenkins-vpc"
}

variable "sub_net_name" {
  type    = string
  default = "jenkins-subnet"
}

variable "sub_net_cidr_block" {
  type    = string
  default = "10.0.0.0/24"
}

variable "sub_net_availability_zone" {
  type    = string
  default = "us-east-1a"
}

variable "internet_gateway_name" {
  type    = string
  default = "jenkins-gw"
}

variable "route_table_name" {
  type    = string
  default = "jenkins-rt"
}

variable "key_pair_name" {
  type    = string
  default = "devops-projects-key"
}

variable "key_pair_path" {
    type    = string
    default = "/home/vinicius/Documents/infra-projects/devops-projects/devops-projects-key.pem"
}

variable "instance_name" {
  type    = string
  default = "jenkins-ec2"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "instance_ami" {
  type    = string
  default = "ami-0c7217cdde317cfec" # ubuntu, us-east-1
}