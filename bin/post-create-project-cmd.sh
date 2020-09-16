#!/usr/bin/env sh

NAME=$(echo $(basename "$PWD") | tr '[:upper:]' '[:lower:]');
NS=$(echo "$NAME" | awk '{ print toupper(substr($0, 1, 1)) substr($0, 2) }');
echo "Project name: $NAME"
echo "Namespace PHP classes: $NS"

# ports could be changed for any project respectively
DB_PORT=3367
echo "Database host use with port: $DB_PORT"

APP_PORT=8081
echo "Webserver host use with port: $APP_PORT"

# necessary for mapping permissions on host and container, this one should be same.
U_ID="$(id -u)"
G_ID="$(id -g)"

echo "Docker Network Subnet: $NEXT_S_NET"

sed -ri -e 's!@S_NET@!'"$NEXT_S_NET"'!g' ./docker-compose.yml
find . -type f -exec sed -ri -e 's!@PROJECT_NS@!'"$NS"'!g' "{}" \;

find . -type f -exec sed -ri -e 's!@PROJECT_NAME@!'"$NAME"'!g' "{}" \;

printf "APPUID=%d\nAPPUGID=%d\nDBPORT=%d\nAPPPORT=%d\n" "$U_ID" "$G_ID" "$DB_PORT" "$APP_PORT" > .env

rm -rv bin composer.json

echo
echo "Please check values are written to .env file now."
echo
