#!/usr/bin/env bash
cd "$(dirname "$0")"
source ../../.env                               # Load Jacker's Environment Variables
source .env                                     # Load Stack Environment Variables


# Delete UFW rules needed by stack
#=================================

# sudo ufw delete allow $VAR


# Remove Assets
#=================================

# sudo rm /usr/local/sbin/


# Stop Stack
#=================================

./dc.sh down

echo Finished $(basename "$0")
