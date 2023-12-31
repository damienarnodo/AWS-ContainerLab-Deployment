# AWS ContainerLab Deployment

This project automates the deployment of ContainerLab on an AWS EC2 instance using Terraform for infrastructure provisioning and Ansible for software setup and configuration. It also configures a Route53 DNS record for easy access to the ContainerLab instance.

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

## Network Images Folder and Naming Convention

### Network Images Folder

The `network_images` folder is intended for Docker images that will be used by ContainerLab. These images should be pre-downloaded and placed in this folder before running the Ansible playbook. During the setup process, the images will be copied to the remote `/tmp` directory of the ContainerLab host and then imported into Docker.

### Naming Convention for Images

It's important to follow a specific naming convention for the images to ensure they are correctly imported into Docker. The naming convention is as follows:

`system_name_without_digit-*-tag.tar.xz`

- `system_name_without_digit`: This part of the filename should include the system name without any digits and need to be written in lower case. The system name will be converted to lowercase during the import process.
- `*`: This is a wildcard segment that can include any characters but should not contain the version or tag information.
- `tag`: This part should specify the version or tag of the image. The tag can include both lowercase and uppercase characters and digits.

#### Example

Given an image file named `cEOS64-lab-4.30.3M.tar.xz`:

- `cEOS64` will be the system name. Digits will be removed `ceos`.
- `4.30.3M` will be the tag, kept as-is.

The image will be imported into Docker with the tag `ceos:4.30.3M`.

Please ensure that all image files in the `network_images` folder conform to this naming convention for the automated process to function correctly.

## Accessing ContainerLab

- You can access the ContainerLab instance via SSH using the public IP or the DNS name provided by Route53.
- The public IP of the instance can be found in the Terraform output.
- The DNS name will be in the format containerlab `<your_route53_zone_name>`

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
