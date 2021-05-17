#!/bin/bash
if ! command -v "docker" &> /dev/null
then
    echo "docker could not be found, install it first"
    exit
fi

if [ "$( docker ps -a | grep -c postgres )" -gt 0 ]; then
  echo "container already exists, starting"
  docker start postgres

else
  echo "container does not exist, creating and starting"
  if [ -z "$POSTGRESPROJECT_DATABASE_PASSWORD" ]
  then
    echo "give a password that you want to run on -> "
    read -r POSTGRESPROJECT_DATABASE_PASSWORD
  fi
  docker run -it -d -p 5432:5432 -v pgdata:/var/lib/postgresql/data -e POSTGRES_PASSWORD="$POSTGRESPROJECT_DATABASE_PASSWORD" --name postgres postgres:13.2-alpine
fi
