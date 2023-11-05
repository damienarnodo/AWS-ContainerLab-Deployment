provider "aws" {
  region     = var.AWS_REGION
  access_key = var.AWS_ACCESS_KEY
  secret_key = var.AWS_SECRET_KEY
}

resource "aws_key_pair" "tf-key-pair" {
  key_name   = "tf-key-pair"
  public_key = tls_private_key.rsa.public_key_openssh
}
resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
resource "local_file" "tf-key" {
  content         = tls_private_key.rsa.private_key_pem
  filename        = "tf-key-pair.pem"
  file_permission = "0600"
}

resource "aws_security_group" "netlab_sg" {
  name = "netlab_sg"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 50080
    to_port     = 50080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "containerlab_host" {
  ami                    = var.AWS_AMIS[var.AWS_REGION]
  instance_type          = "t2.xlarge"
  key_name               = "tf-key-pair"
  vpc_security_group_ids = [aws_security_group.netlab_sg.id]

  provisioner "local-exec" {
    command = "echo ${aws_instance.containerlab_host.public_ip} > ../ansible/inventory"
  }

  provisioner "local-exec" {
    command = "sleep 20; ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u admin -i ../ansible/inventory --private-key ./tf-key-pair.pem ../ansible/install_containerlab.yml"
  }
}