#!/usr/bin/env bash
cd "$(dirname "$0")"                                                    # Change dir to this script's path
source ../../.env			                                            # Load Jacker's Environment Variables
source .env					                                            # Load Stack Environment Variables


sudo ufw delete allow $WG_PORT/udp                                      # Opem Wireguard port
sudo ufw delete allow from $WG_TRAEFIK_SUBNET_IP to any port 22         # Allow VPN clients to connect to host via SSH

echo Finished $(basename "$0")
