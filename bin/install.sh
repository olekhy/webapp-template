#!/usr/bin/env bash

docker-compose down > /dev/null 2>&1
echo
echo
echo "Hinweis: Docker Services sind gerade online (Up)"
docker ps
echo
read -p "Bite verwegenen Sie nicht bereits benutzte Ports!!! ENTER für weiter oder CTRL+C für abbrechen"
echo
read -p "Hinweis: Sie haben ein falschen Port genommen, wenn sie später ein änlichen Fehler sehen 'ERROR: ... Cannot start service ... driver failed programming external connectivity on endpoint'. Installation soll wiederholt werden."
read -p "Geben Sie Port für Datenbank Server an: " -r DBPORT
echo "${DBPORT}"
read -p "Geben Sie Port für HTTP (Apache) Server an: " -r APPPORT
echo "${APPPORT}"

echo "Create .env file in project root directory"
printf "APPUID=%d\nAPPUGID=%d\nDBPORT=%d\nAPPPORT=%d\n" \
$(id -u)    \
$(id -g)    \
"$DBPORT"   \
"$APPPORT"  \
> .env

docker-compose build --parallel --force-rm --no-cache --pull
echo "Finish build images"
docker images | grep "$(basename $PWD)"
docker-compose up -d
docker-compose exec -u $(id -u):$(id -g) app composer install
