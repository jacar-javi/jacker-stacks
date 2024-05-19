#!/usr/bin/env bash
cd "$(dirname "$0")"

source .env-defaults
export SECRET=`head -c 16 /dev/urandom | xxd -ps`
export MTPROTO_PORT=$MTPROTO_PORT
envsubst < .env-template > .env

#envsubst < assets/entrypoint-mtproto-proxy.yml.template > assets/entrypoint-mtproto-proxy.yml
