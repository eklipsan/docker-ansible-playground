# P.S. The project is really raw, so you probably won't understand how to use it

# Docker-Ansible Environment Project

## Introduction

This project provides a Docker-based environment designed for the development and testing of Ansible playbooks. It features a master container equipped with Ansible, SSH, and other essential tools for orchestrating and automating tasks across multiple worker containers. This setup is particularly useful for developers looking to test their Ansible playbooks in a controlled, isolated environment.

## Features

- **Isolated Development Environment**: Utilizes Docker to create an isolated environment that mimics production systems.
- **Ansible Ready**: The master container comes pre-configured with Ansible, allowing for immediate playbook testing and development.
- **Easy Configuration**: Includes Docker Compose and Ansible configuration files for straightforward setup and deployment.
- **SSH Access**: Configured for SSH access to facilitate easy interaction with the containers.

## Prerequisites

Before you begin, ensure you have the following installed on your system:
- Docker
- Docker Compose
- Ansible (for playbook development on the host machine)

## Getting Started

### Setup

1. **Build and Run Containers**:
   Use Docker Compose to build and start the containers.
   ```bash
   docker-compose up --build
   ```
2. **Access Master Container**:
   The master container is configured for SSH access. Use the following command to access it:
   ```bash
   docker exec -it master_container_name bash
   ```
3. **Run Ansible Playbooks**:
   Inside the master container, you can execute Ansible playbooks against the worker containers using the provided inventory and configurations.

### Configuration Files

- `Dockerfile_master` and `Dockerfile_worker`: Dockerfiles for building the master and worker containers, respectively.
- `docker-compose.yaml`: Defines and runs the multi-container Docker application.
- `ansible_files/`: Contains Ansible configuration and inventory files for playbook execution.

## SSH Configuration

SSH is configured to allow root login and password authentication in the containers, facilitating easy access and management.

## Ansible Configuration

The master container is set up with Ansible, ready to run playbooks against the worker containers. The inventory file `ansible_files/inventory.txt` lists the worker containers and their IP addresses for Ansible.

## Network Configuration

A custom bridge network connects the containers, with static IP addresses assigned to each container to simplify network management and playbook execution.

## Environment Variables

Several environment variables are used to customize the setup, including but not limited to `MASTER_ANSIBLE_CONFIG`, `MASTER_DEBIAN_IP`, and `WORKER_DEBIAN_IP`.

## Conclusion

This Docker-Ansible environment project simplifies the process of developing and testing Ansible playbooks. By providing an isolated, easily configurable environment, it allows developers to focus on playbook development without worrying about the underlying infrastructure.

## References

- SSH access to Docker container: [SSH into Docker Container](https://vmblog.ru/ssh-vhod-v-docker-kontejner/)
- Default gateway in Linux: [Default Gateway on StackOverflow](https://stackoverflow.com/questions/1204629/how-do-i-get-the-default-gateway-in-linux-given-the-destination)
