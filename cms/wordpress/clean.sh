#!/usr/bin/env bash
cd "$(dirname "$0")"        # Change dir to this script's path
source ../../.env			# Load Jacker's Environment Variables
source .env					# Load Stack Environment Variables

./stop.sh

sudo rm -rf assets/stack_config/.env
sudo rm -rf assets/stack_config/.FIRST_RUN
sudo rm -rf assets/stack_config/.SECOND_RUN
sudo rm -rf data/nginx/extra.d/*
sudo rm -rf data/html
sudo rm -rf data/mysql
sudo rm -rf data/redis
sudo rm -rf data/wp-cli
sudo rm -rf ../../logs/nginx/$HOSTNAME-access.log
sudo rm -rf ../../logs/nginx/$HOSTNAME-error.log
truncate -s 0 data/nginx/conf.d/optimizations.conf
truncate -s 0 data/php/uploads.ini
mkdir data/html
mkdir data/mysql
mkdir data/wp-cli

echo Finished $(basename "$0")