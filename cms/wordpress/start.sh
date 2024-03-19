#!/usr/bin/env bash
cd "$(dirname "$0")"        # Change dir to this script's path

if [ ! -f ".env" ]; then
    echo You must configure Environment First:
    echo cp .env-sample .env
    echo nano .env
    exit -1
fi

source ../../.env			# Load Jacker's Environment Variables
source .env					# Load Stack Environment Variables

# Prepare Stack Config
sort -u -t '=' -k 1,1 .env ../../.env | grep -v '^$\|^\s*\#' > assets/stack_config/.env
chmod +x assets/stack_config/setup.sh

# Check for Second Run
SECOND_RUN=false
if [[ -f "assets/stack_config/.FIRST_RUN" && ! -f "assets/stack_config/.SECOND_RUN" ]]; then
    SECOND_RUN=true
fi

if [ "$ENABLE_MAX_UPLOADS" = true ]; then
    cp assets/templates/php-max_uploads.ini data/php/uploads.ini
else
    truncate -s 0 data/php/uploads.ini
fi

# Bring up stack
./dc.sh up -d

# Cleanup Wordpress Installation and install base plugins
if [ "$SECOND_RUN" = true ]; then

    # Clean Posts
    ./wpcli.sh wp post delete $(./wpcli.sh wp post list --post_type=post --format=ids)
    ./wpcli.sh wp post delete $(./wpcli.sh wp post list --post_type=page --format=ids)

    # Clean Plugins
    ./wpcli.sh wp plugin delete --all

    # Clean Themes
    ./wpcli.sh wp theme delete $(./wpcli.sh wp theme list --status=inactive --field=name)

    # Install REDIS
    ./wpcli.sh wp config set WP_CACHE_KEY_SALT "wordpress.box2.jacasrsystems.net:"
    ./wpcli.sh wp config set WP_REDIS_HOST "redis"
    ./wpcli.sh wp config set WP_REDIS_PORT 6379
    ./wpcli.sh wp config set WP_REDIS_TIMEOUT 1
    ./wpcli.sh wp config set WP_REDIS_READ_TIMEOUT 1
    ./wpcli.sh wp config set WP_REDIS_DATABASE 0
    ./wpcli.sh wp config set WP_MEMORY_LIMIT "256M"
    ./wpcli.sh wp plugin install redis-cache --activate
    ./wpcli.sh wp redis enable

    # Install Super-Cache
    ./wpcli.sh wp plugin install wp-super-cache --activate
    ./wpcli.sh wp package install https://github.com/wp-cli/wp-super-cache-cli.git
    ./wpcli.sh wp super-cache enable

    # Update wordpress
    ./wpcli.sh wp core update
    ./wpcli.sh wp language core update
    ./wpcli.sh wp language plugin update --all

    touch assets/stack_config/.SECOND_RUN
fi

echo Finished $(basename "$0")
