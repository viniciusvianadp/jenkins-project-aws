provider "aws" {
  region = var.aws_region
}

data "aws_key_pair" "deployer" {
  key_name = var.key_pair_name
}

resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "my_subnet" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = var.sub_net_cidr_block
  availability_zone = var.sub_net_availability_zone

  tags = {
    Name = var.sub_net_name
  }
}

resource "aws_internet_gateway" "my_gw" {
  tags = {
    Name = var.internet_gateway_name
  }
}

resource "aws_internet_gateway_attachment" "ig_vpc" {
  internet_gateway_id = aws_internet_gateway.my_gw.id
  vpc_id              = aws_vpc.my_vpc.id
}

resource "aws_route_table_association" "association" {
  subnet_id      = aws_subnet.my_subnet.id
  route_table_id = aws_route_table.my_rt.id
}

resource "aws_route_table" "my_rt" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_gw.id
  }

  tags = {
    Name = var.route_table_name
  }
}

resource "aws_security_group_rule" "allow_jenkins_ingress" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.allow_all.id
}

resource "aws_security_group" "allow_all" {
  name        = "allow_all"
  description = "Allow traffic from everywhere"
  vpc_id      = aws_vpc.my_vpc.id

  tags = {
    Name = "allow_all"
  }
}

resource "aws_security_group_rule" "allow_all_ingress" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.allow_all.id
}

resource "aws_security_group_rule" "allow_all_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.allow_all.id
}

resource "aws_instance" "jenkins_instance" {
    ami           = var.instance_ami 
    instance_type = var.instance_type
    key_name      = data.aws_key_pair.deployer.key_name
    associate_public_ip_address = true

    user_data = templatefile("./jenkins-runner-script/jenkins-installer.sh", {})

    tags = {
        Name = "jenkins-ec2-instance"
    }

    metadata_options {
        http_endpoint = "enabled"  # Enable the IMDSv2 endpoint
        http_tokens   = "required" # Require the use of IMDSv2 tokens
    }

    vpc_security_group_ids = [aws_security_group.allow_all.id]
    subnet_id              = aws_subnet.my_subnet.id
}

resource "null_resource" "wait_for_jenkins" {
  provisioner "remote-exec" {
    connection {
      host        = aws_instance.jenkins_instance.public_ip
      type        = "ssh"
      user        = "ubuntu"
      private_key = file(var.key_pair_path)
    }

    inline = [
      "until systemctl is-active --quiet jenkins; do sleep 5; done",
    ]
  }

  depends_on = [aws_instance.jenkins_instance]
}

output "public_ip" {
  value = aws_instance.jenkins_instance.public_ip
}