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
3. **Configure variables**: Review and update the `clab_vars.yml` file with necessary values like `tailscale_auth_key`, and `repo_git_url` (or `local_dir_path`).
4. **Run the playbook**: Execute the playbook with the following command:

   ```bash
      ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook \
      -u admin \
      -i ../ansible/inventory \
      --private-key AWS_KEY_LOCATION \
      ../ansible/install_containerlab.yml 
   ```

## Important Variables

- `tailscale_auth_key`: Authentication key for setting up Tailscale.
- `repo_git_url`: URL of the Git repository to be cloned.
- `local_dir_path`: Local directory path for synchronization with the remote machine.

## Directory Structure

- `/opt/containerlab`: Main directory for ContainerLab configurations and projects.
- `/opt/edgeshark`: Directory for EdgeShark configurations, including a Docker Compose file pulled from its repository.

## Usage

After successful installation, ContainerLab and associated tools will be configured and ready to use. You can manage your ContainerLab environments and use Tailscale to connect your labs securely.

## Support

For issues related to the playbook, review the error logs generated during playbook execution or refer to the official documentation of each component (Docker, Tailscale, ContainerLab) installed by this playbook.

## Detailed Task Explanations

1. **Set hostname to ContainerLab**
   - Sets the system hostname to `ContainerLab` to ensure a specific, predictable hostname for network configuration.

2. **Install required system packages**
   - Installs essential packages for running ContainerLab and tools, ensuring the system has necessary dependencies like `curl`, `python3-pip`, etc.

3. **Add Docker GPG apt Key**
   - Adds Docker's official GPG key to ensure the authenticity of the Docker packages from the official repository.

4. **Add Docker Repository**
   - Adds the Docker repository to apt sources to enable installation of the latest Docker versions.

5. **Update apt and install Docker**
   - Updates the apt package index and installs Docker and Docker Compose, necessary for container management.

6. **Add the current user to the Docker group**
   - Adds the ansible user to the Docker group to allow running Docker commands without sudo privileges.

7. **Add Tailscale GPG apt Key**
   - Adds the GPG key for Tailscale to verify the authenticity of the packages.

8. **Add Tailscale Repository**
   - Configures apt to use the Tailscale repository for secure VPN connections.

9. **Update apt and install Tailscale**
   - Installs Tailscale for creating secure networks between devices.

10. **Run Tailscale CLI command**
    - Automatically connects the machine to the Tailscale network using an authorization key.

11. **Add ContainerLab Repository**
    - Adds the official ContainerLab repository for installation of ContainerLab.

12. **Update apt and install ContainerLab**
    - Installs ContainerLab, essential for working with network topologies in a lab environment.

13. **Ensure /opt/containerlab directory exists**
    - Creates and sets permissions for the ContainerLab project directory.

14. **Ensure user 'admin' exists**
    - Ensures there is an `admin` user with adequate permissions for Docker and ContainerLab management.

15. **Ensure the /opt/edgeshark directory exists**
    - Creates a directory for EdgeShark deployments, part of the network monitoring or edge computing setups.

16. **Download the edgeshark docker-compose.yaml file**
    - Pulls a Docker Compose file for EdgeShark, facilitating its deployment.

17. **Clone specified GitHub repository to /opt/containerlab**
    - Clones a repository to the ContainerLab directory for managing project files.

18. **Synchronize local directory to VM**
    - Mirrors local developments to the remote machine, ensuring consistency.

19. **Copy network images to remote /tmp directory**
    - Prepares network images for use in simulations, aiding in topology experiments.
