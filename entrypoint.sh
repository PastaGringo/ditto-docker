#!/bin/sh
echo
echo "  ____  _ _   _        ";
echo " |  _ \(_) |_| |_ ___  ";
echo " | | | | | __| __/ _ \ ";
echo " | |_| | | |_| || (_) |";
echo " |____/|_|\__|\__\___/ ";
echo "                       ";
echo "Ditto's website: https://docs.soapbox.pub/ditto"
echo "Ditto's documentation: https://docs.soapbox.pub/ditto"
echo "Ditto's Nostr: https://njump.me/npub10qdp2fc9ta6vraczxrcs8prqnv69fru2k6s2dj48gqjcylulmtjsg9arpj"
echo
ENV_NSEC=$(grep "^DITTO_NSEC=" .env)
DITTO_NSEC=$(echo "$ENV_NSEC" | cut -d'=' -f2)
echo "╭────────────────────────────╮"
echo "│ Docker Compose Env Vars ⤵️  │"
echo "╰────────────────────────────╯"
echo
echo "SENTRY_DSN            : $SENTRY_DSN"
echo "DITTO_NSEC            : $DITTO_NSEC"
echo "ADMIN_HEX_KEY         : $ADMIN_HEX_KEY"
echo "DITTO_DB_BACKEND      : $DITTO_DB_BACKEND"
echo "POSTGRES_PASSWORD     : $POSTGRES_PASSWORD"
echo "POSTGRES_USER         : $POSTGRES_USER"
echo "POSTGRES_DB           : $POSTGRES_DB"
echo "LOCAL_DOMAIN          : $LOCAL_DOMAIN"
echo "DITTO_UPLOADER        : $DITTO_UPLOADER"
echo "MEDIA_DOMAIN          : $MEDIA_DOMAIN"
echo "BLOSSOM_SERVERS       : $BLOSSOM_SERVERS"
echo
if [ -f "docker_setup_done" ]; then
    echo "Ditto has already been configured. Nothing to do."
    echo
    echo "╭──────────────────────╮"
    echo "│ Starting Ditto... ⤵️  │"
    echo "╰──────────────────────╯"
    echo
    deno task start
else
    echo ">>> Starting Ditto for the first time..."
    echo
    echo "╭─────────────────────────╮"
    echo "│ Configuring Ditto... ⤵️  │"
    echo "╰─────────────────────────╯"
    echo
    echo "DITTO_UPLOADER backend is: $DITTO_UPLOADER"
    case $DITTO_UPLOADER in
        local)
            echo "Using LOCAL Ditto uploader."
            ;;
        blossom)
            echo ">>> Using Blossom to upload media files ✅"
            echo "Blossom servers: $BLOSSOM_SERVERS"
            ;;
        nostrbuild)
            echo ">>> Using Nostr.build to upload media files ✅"
            ;;
        *)
            echo "DITTO_UPLOADER unknown: $DITTO_UPLOADER"
            ;;
esac
    echo
    echo "DITTO_DB_BACKEND backend is: $DITTO_DB_BACKEND"
    # Check if the variable contains "POSTGRES"
    if [[ $DITTO_DB_BACKEND == *"POSTGRES"* ]]; then
        echo ">>> Using Postgres as db backend ✅"
        echo
        echo "> Adding Postgres connection to the ditto .env file..."
        echo "DATABASE_URL=postgresql://$POSTGRES_USER:$POSTGRES_PASSWORD@ditto-postgres-db:5432/$POSTGRES_DB" >> .env
    else
        echo ">>> No Postgres db var used. Using sqlite3 ✅"
    fi
    echo
    echo "> Making user $ADMIN_HEX_KEY Ditto's admin..."
    echo
    deno task admin:role $ADMIN_HEX_KEY admin
    echo
    echo "> Copying Ditto images..."
    cp favicon.ico static/
    cp favicon.ico public/
    mkdir public/instance/images
    cp soapbox-logo.svg public/instance/images/
    mkdir public/images
    cp avi.png public/images
    cp banner.png public/images
    echo
    echo "> Renaming public/instance/soapbox.example.json to public/instance/soapbox.json..."
    mv public/instance/soapbox.example.json public/instance/soapbox.json 
    echo
    echo "Done ✅"
    echo
    echo "╭───────────────────────────────────╮"
    echo "│ 🎉  Ditto has been configured! 🎉 │"
    echo "╰───────────────────────────────────╯"
    touch docker_setup_done
fi
echo
echo "╭──────────────────────╮"
echo "│ Starting Ditto... ⤵️  │"
echo "╰──────────────────────╯"
echo
# deno task dev
deno task start