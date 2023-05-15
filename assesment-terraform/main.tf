resource "aws_instance" "appserver" {
  ami                    = var.ami
  instance_type          = "t2.micro"
  key_name               = "pass"
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  tags = {
    Name = "Main Node"
  }
}
resource "aws_instance" "appserver1" {
  ami                    = var.ami
  instance_type          = "t2.micro"
  key_name               = "pass"
  count                  = var.num_of_instances
  vpc_security_group_ids = [aws_security_group.allow_ssh_http_node.id]
  tags = {
    Name = "node-${count.index+1}"
  }
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh_assesment"
  description = "Allow SSH inbound traffic"

  ingress {
    description = "SSH from public"
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
    Name = "allow_tls"
  }
}
resource "aws_security_group" "allow_ssh_http_node" {
  name        = "allow_ssh_http-assesment"
  description = "Allow SSH HTTP inbound traffic"

  ingress {
    description = "HTTP from public"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "custom tcp port"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH from public"
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
    Name = "allow_tls"
  }
}