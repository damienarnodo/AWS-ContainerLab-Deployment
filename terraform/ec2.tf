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
    cidr_blocks = [var.AWS_LOCAL_IP]
  }
}

resource "aws_instance" "containerlab_host" {
  ami                    = var.AWS_AMI[var.AWS_REGION]
  instance_type          = var.INSTANCE_TYPE
  key_name               = var.AWS_KEY_NAME
  vpc_security_group_ids = [aws_security_group.netlab_sg.id]
  tags = {
    Name = "ContainerLab"
  }

  root_block_device {
    volume_size           = "128"
    volume_type           = "gp2"
    encrypted             = "false"
    delete_on_termination = "true"
  }

  provisioner "local-exec" {
    command = "echo ${aws_instance.containerlab_host.public_ip} > ../ansible/inventory"
  }

  provisioner "local-exec" {
    command = <<EOT
      sleep 20
      ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook \
      -u admin \
      -i ../ansible/inventory \
      --private-key ${var.AWS_KEY_LOCATION} \
      ../ansible/install_containerlab.yml 
    EOT
  }
}