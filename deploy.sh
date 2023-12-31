#!/bin/bash
if [ -d "hitcount-app" ]; then
  echo "hitcount-app does exist."
  rm -rf hitcount-app
fi
git clone https://github.com/socgenaws/hitcount-app.git
cd hitcount-app
docker-compose stop
docker-compose rm -f
docker-compose up -d --force-recreate
docker-compose ps 