#!/bin/bash

# Function to validate IP address
validate_ip() {
    local ip=$1
    local stat=1

    if [[ $ip =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}(/[0-9]{1,2})?$ ]]; then
        IFS='/' read -r ip mask <<< "$ip"
        IFS='.' read -r -a octets <<< "$ip"
        if [[ ${octets[0]} -le 255 && ${octets[1]} -le 255 && ${octets[2]} -le 255 && ${octets[3]} -le 255 ]]; then
            if [[ -z $mask || ($mask -ge 0 && $mask -le 32) ]]; then
                stat=0
            fi
        fi
    fi

    if [[ $stat -eq 0 ]]; then
        return 0
    else
        echo "Invalid IP address or subnet mask format. Please enter a valid value."
        return 1
    fi
}

# Function to read input with validation
read_with_validation() {
    local __resultvar=$1
    local __default=$2
    local __prompt=$3
    local __value
    while true; do
        read -p "$__prompt [${__default}]: " __value
        __value=${__value:-$__default}
        if validate_ip $__value; then
            eval $__resultvar="'$__value'"
            break
        fi
    done
}

# Main function to run the setup
setup() {
    # Explain the project's idea
    echo "This script sets up a Docker-based environment for developing and testing Ansible playbooks."
    echo "Values framed by square brackets are inserted into variables at empty input."

    # Get network configuration from the user or use default values with validation
    read_with_validation SUBNET "192.168.0.0/24" "Enter your subnet address with mask"
    read_with_validation GATEWAY "192.168.0.1" "Enter your gateway address"
    read_with_validation MASTER_DEBIAN_IP "192.168.0.200" "Enter the IP address of the master node"
    read_with_validation FIRST_WORKER_DEBIAN_IP "192.168.0.201" "Enter the IP address of the first worker"
    read_with_validation SECOND_WORKER_DEBIAN_IP "192.168.0.202" "Enter the IP address of the second worker"

    # Output the variables for user confirmation
    echo "You have entered the following configuration:"
    echo "Subnet: $SUBNET"
    echo "Gateway: $GATEWAY"
    echo "Master Node IP: $MASTER_DEBIAN_IP"
    echo "First Worker IP: $FIRST_WORKER_DEBIAN_IP"
    echo "Second Worker IP: $SECOND_WORKER_DEBIAN_IP"
    echo "Do you want to retype the values? (YES/NO): "
    read confirmation
    if [[ $confirmation =~ ^[Yy][Ee][Ss]$ ]]; then
        setup # Restart the setup function
    else
        # Export the variables for docker-compose to use
        export SUBNET GATEWAY MASTER_DEBIAN_IP FIRST_WORKER_DEBIAN_IP SECOND_WORKER_DEBIAN_IP

        echo "[local]" > ansible_files/inventory.txt
        echo "127.0.0.1 ansible_connection=local" >> ansible_files/inventory.txt
        echo "[workers]" >> ansible_files/inventory.txt
        echo "first_worker ansible_host=$FIRST_WORKER_DEBIAN_IP" >> ansible_files/inventory.txt
        echo "second_worker ansible_host=$SECOND_WORKER_DEBIAN_IP" >> ansible_files/inventory.txt

        # Execute docker-compose up -d
        echo "All variables are entered"
        echo "Launching docker composing"
        docker-compose up -d

        # Enter the master node
        echo "Type the following command to enter master container:"
        echo "For Linux: docker exec -it master_debian bash"
        echo "For Windows: winpty docker exec -it master_debian bash"
    fi
}

# Start the setup process
setup