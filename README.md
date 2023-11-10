# ContainerLab on AWS Automation

This project automates the deployment of ContainerLab tools on an AWS EC2 instance using Terraform for infrastructure provisioning and Ansible for software configuration and management.

## Project Structure

- **Terraform/**: Contains Terraform configurations for AWS resources creation.
- **Ansible/**: Holds the Ansible playbook and roles for installing and configuring ContainerLab.

## Prerequisites

- AWS Account
- Terraform installed
- Ansible installed
- SSH key configured
- Route 53 domaine configured

## Usage

### Terraform

Navigate to the `terraform/` directory:

```bash
cd terraform/
```

Initialize Terraform:

```bash
terraform init
```

Apply the Terraform configuration:

```bash
terraform apply
```

### Ansible

After the EC2 instance is up, navigate to the `ansible/` directory:

```bash
cd ../ansible/
```

Run the Ansible playbook:

```bash
ansible-playbook -i ansible/inventory ansible/install_containerlab.yml -u admin --private-key terraform/tf-key-pair.pem
```

## Customization

- **Terraform Variables**: Customize your deployment by updating `variables.tf`.
- **Terraform Secret**: Configure your AWS access by creating `terraform.tfvars`.

## License

Distributed under the MIT License. See `LICENSE` for more information.
