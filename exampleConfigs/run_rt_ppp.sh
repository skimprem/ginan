#!/bin/bash
# Script to run PEA with credentials from .env file

# Load environment variables from .env file
if [ -f ../.env ]; then
    export $(cat ../.env | grep -v '^#' | xargs)
else
    echo "Error: .env file not found in repository root"
    echo "Create .env file with the following content:"
    echo "NTRIP_USER=your_username"
    echo "NTRIP_PASS=your_password"
    exit 1
fi

# Replace placeholders with values from environment variables
sed "s/your_ntrip_user/$NTRIP_USER/g; s/your_ntrip_pass/$NTRIP_PASS/g" rt_ppp_example.yaml > rt_ppp_example.yaml.tmp

# Run the program
../bin/pea --config rt_ppp_example.yaml.tmp

# Clean up temporary file
rm -f rt_ppp_example.yaml.tmp
