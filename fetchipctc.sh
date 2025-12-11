#!/bin/bash

# Get the scaling information
scalinginfo_resource_group="RG-SERVICES-PROD-CYRA-Whizrange-ICL-01"
scalinginfo_scaleset_name="SS-LIN-SERVICES-PROD-CYRA-WHIZRANGE-ICL-CTC-03"

# Function to retrieve VMSS instance public IP addresses
get_vmss_instance_ips() {
    local resource_group="$1"
    local scaleset_name="$2"
    az vmss list-instance-public-ips --resource-group "$resource_group" --name "$scaleset_name" --output tsv --query "[].ipAddress"
}

# Get the public IP addresses of VM instances in VMSS
ip_addresses=$(get_vmss_instance_ips "$scalinginfo_resource_group" "$scalinginfo_scaleset_name")

# Write the IP addresses to ip_addresses.txt
echo "$ip_addresses" > ip_ctc_icl.txt
