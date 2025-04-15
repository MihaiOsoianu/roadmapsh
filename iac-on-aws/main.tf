provider "aws" {
  region  = "us-east-1"
  profile = "vscode"
}

resource "aws_vpc" "iac-vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "iac-on-aws-vpc"
  }
}

resource "aws_subnet" "iac-public-subnet" {
  vpc_id                  = aws_vpc.iac-vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "iac-on-aws-public-subnet"
  }
}

resource "aws_internet_gateway" "iac-internet-gateway" {
  vpc_id = aws_vpc.iac-vpc.id

  tags = {
    Name = "iac-igw"
  }
}

resource "aws_route_table" "iac-public-rt" {
  vpc_id = aws_vpc.iac-vpc.id

  tags = {
    Name = "iac-public-rt"
  }
}

resource "aws_route" "default_route" {
  route_table_id         = aws_route_table.iac-public-rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.iac-internet-gateway.id
}

resource "aws_route_table_association" "iac-public-assoc" {
  subnet_id      = aws_subnet.iac-public-subnet.id
  route_table_id = aws_route_table.iac-public-rt.id
}

resource "aws_security_group" "sg-web-server" {
  name        = "web-server"
  description = "Allow http/https access inbound and all outbound traffic."
  vpc_id      = aws_vpc.iac-vpc.id

  tags = {
    Name = "web-server"
  }

  dynamic "ingress" {
    for_each = [80, 443]
    content {
      from_port        = ingress.value
      to_port          = ingress.value
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
  }
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic" {
  security_group_id = aws_security_group.sg-web-server.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_security_group" "sg-ssh-access" {
  name        = "ssh-access"
  description = "Allow SSH inbound access."
  vpc_id      = aws_vpc.iac-vpc.id

  tags = {
    Name = "ssh-access"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.sg-ssh-access.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "tcp"
  from_port         = 22
  to_port           = 22
}

data "aws_key_pair" "web-server-key" {
  key_name           = "main-key-aws"
  include_public_key = true
}

data "aws_ami" "amazon-linux" {
  most_recent = true
  owners      = ["137112412989"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023*"]
  }
}

resource "aws_instance" "web" {
  ami                    = data.aws_ami.amazon-linux.id
  instance_type          = "t2.micro"
  key_name               = data.aws_key_pair.web-server-key.key_name
  subnet_id              = aws_subnet.iac-public-subnet.id
  vpc_security_group_ids = [aws_security_group.sg-ssh-access.id, aws_security_group.sg-web-server.id]

  root_block_device {
    volume_size = 10
  }

  tags = {
    Name = "web-server"
  }

  provisioner "remote-exec" {
    inline = ["echo Instance is ready"]
    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("~/.ssh/key.pem")
      host        = self.public_ip
    }
  }

  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i '${self.public_ip},' -u ec2-user --private-key ~/.ssh/key.pem ./ansible/setup.yml"
  }
}

output "public_ip" {
  value = aws_instance.web.public_ip
}