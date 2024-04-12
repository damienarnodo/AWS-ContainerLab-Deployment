# AWS ContainerLab Deployment

This project automates the deployment of ContainerLab on an AWS EC2 instance using Terraform for infrastructure provisioning and Ansible for software setup and configuration. It also configures a [tailscale access](https://tailscale.com) for easy access to the ContainerLab instance.

## Prerequisites

Before you begin, ensure you have the following prerequisites installed and configured:

- AWS CLI
- Terraform
- Ansible
- Ansible module :
  - [ansible.posix](https://galaxy.ansible.com/ui/repo/published/ansible/posix/)
  - [community.docker](https://docs.ansible.com/ansible/latest/collections/community/docker/docker_compose_module.html)
- Git (if cloning the repository)
- An AWS account with the necessary permissions
- A configured [AWS Key Pair](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/create-key-pairs.html)
- Tailscale [Authentication Key](https://tailscale.com/kb/1085/auth-keys)

## Installation

1. **Configure AWS Credentials and Variables**

    Set your AWS credentials and other sensitive data in **terraform/terraform.tfvars**.  
    Example:

    ```tfvars
    AWS_ACCESS_KEY = "your_access_key"
    AWS_SECRET_KEY = "your_secret_key"
    AWS_REGION     = "desired_aws_region"
    AWS_KEY_NAME   = "your_key_pair_name"
    ```

    Set your Tailscale Key and your git repository or local folder in **ansible/clab_variables.yml**

    ```yml
    repo_git_url: ""
    local_dir_path: ""
    tailscale_auth_key: ""
    ```

    **Important**: Never commit terraform.tfvars to version control as it contains sensitive information.

2. **Clone the Repository**

   If you haven't already, clone this repository to your local machine:

   ```bash
   git clone <repository_url>
   cd AWS-ContainerLab-Deployment
   ```

3. **Initialize Terraform**

    Navigate to the Terraform directory and initialize the Terraform environment:

    ```bash
    cd terraform
    terraform init
    ```

4. **Apply Terraform Configuration**

    Apply the Terraform configuration to start the deployment:

    ```bash
    terraform apply
    ```

5. **Ansible Automation**

    The Terraform configuration will automatically trigger the Ansible playbook install_containerlab.yml after the EC2 instance is up. This playbook configures the instance with the necessary packages and settings, installs ContainerLab, and optionally clones the specified GitHub repository.

## Network Images Folder

The `network_images` folder is intended for Docker images that will be used by ContainerLab. These images should be pre-downloaded and placed in this folder before running the Ansible playbook. During the setup process, the images will be copied to the remote `/tmp` directory of the ContainerLab host and then imported into Docker.

## Customization

- You can customize the deployment by modifying the Terraform variables in **terraform/variables.tf**.
- The Ansible playbook can be customized by editing **ansible/install_containerlab.yml**.
- You have to configure Ansible by add variables in **ansible/clab_variables.yml**

## Clean Up

To destroy the AWS resources created by Terraform, run:

```bash
terraform destroy
```

Enter **\`yes\`** when prompted.

## Contributing

Contributions to this project are welcome. Please ensure you follow the established coding standards and update the documentation as necessary.

## License

This project is licensed under the MIT License - see the LICENSE file for details.
