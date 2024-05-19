#!/usr/bin/env bash
cd "$(dirname "$0")"        # Change dir to this script's path
source ../../.env			# Load Jacker's Environment Variables
source .env					# Load Stack Environment Variables

./open_firewall.sh
./dc.sh up -d

echo Finished $(basename "$0")
