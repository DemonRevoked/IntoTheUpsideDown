#!/bin/bash

# Define the username and password for SSH connection
USERNAME="ctcrootuser"
PASSWORD="CTCr00Tus3r#p4ssw0rd"

# Read IP addresses from ip_address.txt and convert to an array
readarray -t ip_addresses < ip_ctc_icl.txt

# Chunk size for processing
chunk_size=10

# Process IP addresses in chunks
for ((i = 0; i < ${#ip_addresses[@]}; i+=chunk_size)); do
    chunk=("${ip_addresses[@]:i:chunk_size}")
    for ip_address in "${chunk[@]}"; do
        if [[ $ip_address =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
            # Run SSH commands in the background
            sshpass -p "$PASSWORD" ssh -o StrictHostKeyChecking=no "$USERNAME"@"$ip_address" << EOF &
                sudo ./setup.sh

EOF
            echo "Commands executed on $ip_address"
            echo "$ip_address," >> masteriplist.txt
        else
            echo "Invalid IP address: $ip_address"
        fi
    done
    # Wait for all background processes to finish before moving to the next chunk
    wait
done

# Clean up and sort masteriplist.txt
sort -u masteriplist.txt -o masteriplist.txt
