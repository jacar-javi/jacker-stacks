#!/usr/bin/env bash
cd "$(dirname "$0")"        # Change dir to this script's path


# Remove Data
#=================================
sudo rm -rf data/config || true
sudo rm -rf .env || true
sudo rm -rf assets/entrypoint-mtproto-proxy.yml || true

echo Finished $(basename "$0")