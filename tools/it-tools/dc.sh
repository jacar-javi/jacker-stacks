#!/usr/bin/env bash
cd "$(dirname "$0")"
source ../../.env
source .env

for var in "$@"
        do
                argstopass="$argstopass $var"
        done

docker compose --env-file ../../.env --env-file .env $argstopass
