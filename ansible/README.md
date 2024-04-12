# README for Ansible Playbook: ContainerLab Installation

This README provides detailed information about the Ansible playbook designed for setting up and configuring ContainerLab, along with Docker, Tailscale, and additional system tools on Ubuntu hosts.

## Overview

The playbook is structured to run a series of tasks including setting the hostname, installing required system packages, configuring Docker and Tailscale repositories, and installing ContainerLab. It ensures that necessary directories are created, and relevant permissions are set up for a seamless user experience.

## Key Features

- **Hostname Configuration**: Sets the system hostname to `ContainerLab`.
- **System Packages**: Installs essential packages such as `curl`, `git`, `python3-pip`, and several others necessary for running ContainerLab and associated tools.
- **Docker Setup**: Adds Docker's official GPG key and repository, installs Docker and Docker Compose, and adds the executing user to the Docker group.
- **Tailscale VPN**: Configures the Tailscale repository and installs it for creating secure networks.
- **ContainerLab Installation**: Sets up the ContainerLab repository, installs ContainerLab, and ensures necessary directories and user configurations are in place.
- **Project and Data Management**: Clones a specified GitHub repository, synchronizes local directories, and manages network images within the target system.

## Installation Steps

1. **Prepare your inventory**: Ensure your Ansible inventory file is updated with the hostnames or IP addresses of the target machines.
2. **Clone the playbook**: Download or clone this playbook repository to your control machine.
3. **Configure variables**: Review and update the `clab_vars.yml` file with necessary values like `ansible_user_id`, `tailscale_auth_key`, and `repo_git_url`.
4. **Run the playbook**: Execute the playbook with the following command:

   ```bash
    ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook \
      -u admin \
      -i inventory \
      --private-key AWS_KEY_LOCATION \
      install_containerlab.yml 
    ```

## Important Variables

- **`tailscale_auth_key`** : Authentication key for setting up Tailscale.
- **`repo_git_url`** : URL of the Git repository to be cloned.
- **`local_dir_path`** : Local directory path for synchronization with the remote machine.

## Directory Structure

- **`/opt/containerlab`**: Main directory for ContainerLab configurations and projects.
- **`/opt/edgeshark`**: Directory for EdgeShark configurations, including a Docker Compose file pulled from its repository.
