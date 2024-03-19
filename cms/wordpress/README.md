# Jacker Stack: Wordpress

This template is the base docker stack structure to integrate with Jacker core services.

It contains the next structure:

```
├── assets
│   ├── <stack assets, scripts>
├── compose
│   ├── <stack service files yaml>
├── data
│   ├── <stack data folders>
├── secrets
│   ├── <stack secret files>
├── clean.sh
├── dc.sh
├── docker-compose.yml
├── README.md
├── start.sh
├── stop.sh
├── .env-sample
└── .gitignore
```

## Step 1: Configure Environment

```
cp .env-sample .env
nano .env
```

Stack's Environment File. It contains all environment variables used. Configure to suit your needs

## Step 2: Run Stack for the first time: Install Wordpress

```
./start.sh
```

Open your browser to https://wordpress.myexample.com (as configured in .env file).
Install Wordpress.

## Step 3: Restart Stack

```
./restart.sh
```

After Wordpress is installed, it will include all security hardening options, clean all plugins and themes, posts, pages and configure Redis and WP Super Cache.

Voilá, your wordpress installation is ready for production.

## clean.sh

It will *remove all data* and will let the stack as it was at the first time of use.

