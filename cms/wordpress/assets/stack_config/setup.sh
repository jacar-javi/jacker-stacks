#!/usr/bin/env sh
cd "$(dirname "$0")"        # Change dir to this script's path
source .env					# Load Stack Environment Variables

envsubst < templates/logs.conf > /etc/nginx/extra.d/logs.conf

if [ -f ".FIRST_RUN" ]; then
    cp templates/harden-wordpress.conf /etc/nginx/extra.d
else
    rm -rf /etc/nginx/extra.d/harden-wordpress.conf
    touch /etc/nginx/extra.d/harden-wordpress.conf
fi

if [ "$ENABLE_MAX_UPLOADS" = true ]; then
    cp templates/nginx-max_uploads.conf /etc/nginx/conf.d/optimizations.conf
else
    cp templates/nginx-optimizations.conf /etc/nginx/conf.d/optimizations.conf
fi

touch .FIRST_RUN

echo Finished $(basename "$0")