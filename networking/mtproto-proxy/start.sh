#!/usr/bin/env bash
cd "$(dirname "$0")"        # Change dir to this script's path
source ../../.env			# Load Jacker's Environment Variables
source .env					# Load Stack Environment Variables



# Set Permissions
#=================================
# sudo chmod 600 data/acme.json


# Add UFW rules needed by stack
#=================================

./open_firewall.sh


# Copy Assets
#=================================

#sudo cp assets/entrypoint-mtproto-proxy.yml ../../data/traefik/rules



# Start Stack
#=================================

./dc.sh up -d

echo "Your Telegram\'s MTPROTO proxy is now running."
echo "Go to your Telegram\'s client and click Setup > Advanced > Data and Storage > Connection"
echo "Add new MTPROTO proxy"
echo "Host: $PUBLIC_FQDN  Port: $MTPROTO_PORT"
echo "Key: $SECRET"

echo Finished $(basename "$0")
