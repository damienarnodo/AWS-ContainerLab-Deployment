# AWS ContainerLab Deployment

This project automates the deployment of ContainerLab on an AWS EC2 instance using Terraform for infrastructure provisioning and Ansible for software setup and configuration. It also configures a Route53 DNS record for easy access to the ContainerLab instance.

## To Do

- [ ] Improving documentation
- [ ] Complete DNS configuration conditioning

## Prerequisites

Before you begin, ensure you have the following prerequisites installed and configured:

- AWS CLI
- Terraform
- Ansible
- Git (if cloning the repository)
- An AWS account with the necessary permissions
- A configured AWS Key Pair

## Installation

1. **Configure AWS Credentials and Variables**

    Set your AWS credentials and other sensitive data in **terraform/terraform.tfvars**.  
    Example:

    ```bash
    AWS_ACCESS_KEY = "your_access_key"
    AWS_SECRET_KEY = "your_secret_key"
    AWS_REGION     = "desired_aws_region"
    AWS_KEY_NAME   = "your_key_pair_name"
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

    If you want to clone a specific GitHub repository during installation, pass the repository URL as a variable:

    ```bash
    terraform apply -var="GITHUB_REPO_URL=https://github.com/MasqAs/projet-vxlan-automation"
    ```

    Or, if you want to push a local directory:

    ```bash
    terraform apply -var="LOCAL_DIR_PATH=/path/to/your/local/directory"
    ```

    >:pen:  **if you use the local folder**  
    >Note that there is no synchronization between your remote folder and your local folder once the instance has been created.

    Enter `yes` when prompted to proceed.

5. **Ansible Automation**

    The Terraform configuration will automatically trigger the Ansible playbook install_containerlab.yml after the EC2 instance is up. This playbook configures the instance with the necessary packages and settings, installs ContainerLab, and optionally clones the specified GitHub repository.

## Network Images Folder

The `network_images` folder is intended for Docker images that will be used by ContainerLab. These images should be pre-downloaded and placed in this folder before running the Ansible playbook. During the setup process, the images will be copied to the remote `/tmp` directory of the ContainerLab host and then imported into Docker.

## Accessing ContainerLab

- You can access the ContainerLab instance via SSH using the public IP or the DNS name provided by Route53.
- The public IP of the instance can be found in the Terraform output.
- The DNS name will be in the format containerlab `<your_route53_zone_name>`.

> :warning: **ROUTE 53**  
> By default, Route 53 is disabled to avoid errors in case of incomplete configuration.  
> To enable it, modify the variables: `AWS_R53_ENABLED` and `AWS_R53_ZONE_ID`.  
> In any case, `AWS_R53_ZONE_ID` need to be configured.

## Customization

- You can customize the deployment by modifying the Terraform variables in **terraform/variables.tf**.
- The Ansible playbook can be customized by editing **ansible/install_containerlab.yml**.

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
