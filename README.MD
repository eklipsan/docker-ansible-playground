# Docker ansible playground

## Introduction

This project provides a Docker-based environment designed for the testing of Ansible. It features a master container equipped with Ansible, SSH, and other essential tools for orchestrating and automating tasks across multiple worker containers. Both master and workers use **Debian** system. This is useful for students looking to learn Ansible in a controlled, isolated environment.

## Features

- **Isolated Development Environment**: Utilizes Docker to create an isolated environment that mimics production systems.
- **Ansible Ready**: The master container comes pre-configured with Ansible, allowing for immediate playbook testing and development.
- **Simple configuration**: the project spans the volume between the ansible_files folder on your local node and the ansible folder on the master container. This makes it easy to interact with ansible via a convenient text editor, meaning you can change the ansible_files folder, which reflects the current ansible settings on the master container.
- **SSH Access**: Configured for SSH access to facilitate easy interaction with the all containers.

## Prerequisites

All you need is only Docker (Docker Compose) and if you use Windows, then you need a terminal with unix command support (for example, git bash)

## Getting Started

### Setup
1. **Clone this repo and go to "docker-ansible-playground" folder**
   ```bash
   git clone https://github.com/eklipsan/docker-ansible-playground.git
   cd docker-ansible-plaground
   ```
2. **Build and Run Containers**:
   Use handy bash script `init_ansible_playground` to configure your ansible setup.
   ```bash
   chmod 777 init_ansible_playground
   ./init_ansible_playground
   ```
P.S. If you are deploying the project to https://labs.play-with-docker.com, then you just need to use the default values given in square brackets by simply pressing Enter

3. Using this script you'll be asked questions to customize ansible playground. A small instruction how to configure it correctly:
- Enter your address of the subnet that has access to the Internet for best performance with ansible, with a shortened mask like 192.168.1.0/24
- Enter the gateway address of your entered subnet. Example 192.168.1.1
- Now you need to enter the ip addresses for the master and worker containers. Enter the addresses that are included in the subnet entered earlier and those that are free. For example, 192.168.213

After entering the parameters, the process of building containers will start (1-2 minutes) and at the end you will find yourself in the master container in the working directory of ansible. where you can start learning this tool.

### Configuration Files

- `Dockerfile_master` and `Dockerfile_worker`: Dockerfiles for building the master and worker containers, respectively.
- `docker-compose.yaml`: Defines and runs the multi-container Docker application.
- `ansible_files/`: Contains Ansible configuration and inventory files for playbook execution.
- `sshd_config`: Contains modified ssh parameters to allow access to the container via ssh
- `container_script.sh`: Contains a small bash script that starts the ssh service on containers and keeps them from crashing.
- `.env`: Shows the variables that are used by the 'docker-compose.yaml' file

## SSH Configuration

SSH is configured to allow root login and password authentication in the containers, facilitating easy access and management.
If you want to connect to the container explicitly via ssh, the username and password are 'root'
```bash
ssh root@xxx.xxx.xxx.xxx
# Then enter "root" word
```

## Ansible Configuration

The master container is set up with Ansible, ready to run playbooks against the worker containers. The inventory file `ansible_files/inventory.txt` lists the worker containers and their IP addresses for Ansible. Other worker parameters can be found in ansible/group_vars/workers

## Conclusion

This project simplifies the process of developing and testing Ansible playbooks. By providing an isolated, easily configurable environment, it allows developers to focus on playbook development without worrying about the underlying infrastructure.

## Feedback

I would be be thankful for any criticism and suggestions about this project.

kshabalin11@yandex.ru

https://t.me/eklipsan
