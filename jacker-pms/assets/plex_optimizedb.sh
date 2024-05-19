#!/usr/bin/env bash
cd "$(dirname "$0")"        # Change dir to this script's path
source ../../.env			# Load Jacker's Environment Variables
source .env                 # Load Stack Environment Variables

sudo apt-get update
Sudo apt-get install sqlite
../stop.sh

# If you have big library (and especially if plex.db is not on SSD) its worth expanding default cache size in plex database. With this changes the DB pages will be put into RAM to improve performance.
sqlite3 -header -line "../data/plex/config/Library/Application Support/Plex Media Server/Plug-in Support/Databases/com.plexapp.plugins.library.db" "PRAGMA default_cache_size = 1000000"