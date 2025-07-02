#!/usr/bin/env bash

# Convert password last changed date to human readable format

read -p "Username: " NAME

# Validate user
if ! id "$NAME" &>/dev/null; then
    echo "User '$NAME' does not exist."
    exit 1
fi

# Get days since epoch from /etc/shadow
DAYS=$(sudo grep "^${NAME}:" /etc/shadow | cut -d: -f3)

if [[ -z "$DAYS" ]]; then
    echo "Could not retrieve password change date."
    exit 1
fi

echo "Password last changed on:"
date -d "1970-01-01 UTC + $DAYS days"

