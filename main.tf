provider "aws" {
    region = var.region
    shared_credentials_file = "~/.aws/credentials"
    profile = var.awsprofile
}

resource "aws_vpc" "vpc" {
    cidr_block = "10.0.0.0/16"

    tags = {
        Name = "terraria vpc"
    }
}

resource "aws_internet_gateway" "gw" {
    vpc_id = aws_vpc.vpc.id

    tags = {
        Name = "terraria gateway"
    }
}

resource "aws_route_table" "rt" {
    vpc_id = aws_vpc.vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.gw.id
    }
}

resource "aws_subnet" "subnet" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "${var.region}${var.az}"

    tags = {
        Name = "terraria subnet"
    }
}

resource "aws_route_table_association" "a" {
    subnet_id = aws_subnet.subnet.id
    route_table_id = aws_route_table.rt.id
}

resource "aws_security_group" "sg" {
    name = "Terraria SG"
    description = "Allows SSH and Terraria port"
    vpc_id = aws_vpc.vpc.id

    ingress {
        description = "Terraria ingress"
        from_port = var.terrariaport
        to_port = var.terrariaport
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        description = "SSH"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_network_interface" "nic" {
    subnet_id = aws_subnet.subnet.id
    private_ips = ["10.0.1.77"]
    security_groups = [aws_security_group.sg.id]
}

resource "aws_eip" "eip" {
    vpc = true
    network_interface = aws_network_interface.nic.id
    associate_with_private_ip = "10.0.1.77"
    depends_on = [aws_internet_gateway.gw]
}

resource "aws_ebs_volume" "ebs" {
  availability_zone = "${var.region}${var.az}"
  size              = 8

  tags = {
    Name = "Terraria Storage"
  }
}

resource "aws_volume_attachment" "ebs_att" {
    device_name = "/dev/sdh"
    volume_id = aws_ebs_volume.ebs.id
    instance_id = aws_instance.terra.id
}

data "aws_ami" "ec2_ami" {
    most_recent = true
    owners = ["amazon"]

    filter {
        name = "name"
        values = ["amzn2-ami-hvm-2*"]
    }
}

resource "aws_instance" "terra" {
    ami = data.aws_ami.ec2_ami.id
    instance_type = var.ec2_type
    availability_zone = "${var.region}${var.az}"
    key_name = var.key_name
    user_data = <<-EOF
                #!/bin/bash
                sudo amazon-linux-extras install ansible2 -y
                ansible-playbook terra.yml
                EOF
    
    network_interface {
        device_index = 0
        network_interface_id = aws_network_interface.nic.id
    }

    tags = {
        Name = "terraria server"
    }
}

output "instance_ip" {
    value = aws_eip.eip.public_ip
    description = "The public IP address of the Terraria server instance."
}

#template file
#write a readme file

#install ansible on localhost with userdata, fetch terraria ansible from github repo branch, installs it.
