# Terraform Deployment

This directory contains the Terraform configuration files for deploying an AWS EC2 instance with ContainerLab.

## Prerequisites

- Terraform installed on your local machine
- AWS CLI configured with your credentials
- An AWS account with the necessary permissions

## Configuration

1. **Set AWS Credentials and Variables**

   Rename the `terraform.tfvars.sample` to `terraform.tfvars` and update the following variables with your own values:

   ```tfvars
   AWS_ACCESS_KEY = "your_access_key"
   AWS_SECRET_KEY = "your_secret_key"
   AWS_KEY_NAME   = "your_key_pair_name"
   AWS_KEY_LOCATION = "path_to_your_private_key"
   ```

    **Important** : Never commit `terraform.tfvars` to version control as it contains sensitive information.

2. **Customize Terraform Variables**

    You can customize the deployment by modifying the Terraform variables in `variables.tf`.

## Action made by the EC2.tf file

1. **AWS Provider Configuration**: It sets up the AWS provider with the region, access key, and secret key specified in the Terraform variables.

   ```tf
   provider "aws" {
     region     = var.AWS_REGION
     access_key = var.AWS_ACCESS_KEY
     secret_key = var.AWS_SECRET_KEY
   }
   ```

2. **Security Group Creation**: It creates a new AWS security group named `netlab_sg`. This security group allows all outbound traffic and only inbound SSH (port 22) traffic from the IP address specified in the `AWS_LOCAL_IP` variable.

   ```tf
   resource "aws_security_group" "netlab_sg" {
     ...
   }
   ```

3. **EC2 Instance Creation**: It creates a new AWS EC2 instance with the specified AMI, instance type, and key pair. The instance is associated with the `netlab_sg` security group. The instance is tagged with the name "ContainerLab".

   ```tf
   resource "aws_instance" "containerlab_host" {
     ...
   }
   ```

4. **Root Block Device Configuration**: It configures the root block device of the EC2 instance with a volume size of 128 GB, a volume type of `gp2`, encryption disabled, and deletion on termination enabled.

   ```tf
   root_block_device {
     ...
   }
   ```

5. **Local Provisioners**: It uses two local provisioners to perform actions on the local machine after the EC2 instance is created:

   - The first provisioner writes the public IP address of the newly created EC2 instance to the `../ansible/inventory` file.

     ```tf
     provisioner "local-exec" {
       command = "echo ${aws_instance.containerlab_host.public_ip} > ../ansible/inventory"
     }
     ```

   - The second provisioner waits for 20 seconds and then runs the Ansible playbook `install_containerlab.yml` using the `ansible-playbook` command. The playbook is run against the new EC2 instance.

     ```tf
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
     ```

These actions together set up an AWS environment with a configured EC2 instance ready to run ContainerLab.
