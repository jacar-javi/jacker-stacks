#!/usr/bin/env bash
cd "$(dirname "$0")"        # Change dir to this script's path
source ../../.env			# Load Jacker's Environment Variables
source .env					# Load Stack Environment Variables


sudo ufw allow $WG_PORT/udp
sudo ufw allow from $WG_TRAEFIK_SUBNET_IP to any port 22

echo Finished $(basename "$0")
