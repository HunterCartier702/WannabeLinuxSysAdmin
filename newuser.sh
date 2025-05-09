#!/bin/bash

# Usage: sudo ./newuser.sh <username>

username="$1"
exists=$(getent passwd "$username")

# Check if run as root
if [[ $EUID -ne 0 ]]; then 
    echo "Run with sudo. Exiting."
    exit 1

# Check if username provided
elif [[ -z "$username" ]]; then
    echo -e "Provide a username arg\nUsage: sudo ./newuser.sh <username>"
    exit 1

# Check if user already exists
elif [[ -n $exists ]]; then 
    echo "User '$username' already exists. Exiting."
    exit 1
else
    # Create user with home directory and default shell
    useradd -m -d /home/"$username" -s /bin/bash "$username"

    echo -e "\tCreated user: $username"
    echo -e "\tUID: $(id -u "$username")"
    echo -e "\tGID: $(id -g "$username")"
    echo -e "\tHome directory: /home/$username"
fi

# Prompt for password 
echo -e "\nSet a password for '$username':"
passwd "$username"

