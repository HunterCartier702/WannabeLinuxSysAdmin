#!/bin/bash

# Grabs public ip

IP=$(curl -s https://httpbin.org/ip | jq -r '.origin')
echo -e "Public ip:\n$IP"
