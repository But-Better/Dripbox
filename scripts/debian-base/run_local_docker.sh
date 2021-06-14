#!/bin/bash

function stop_local_postgres_server_if_running() {
    if [ "$(sudo systemctl list-unit-files | grep -c postgresql.service)" -gt 0 ]; then
      sudo systemctl disable --now postgresql.service
    fi
}
function removeOldDocker() {
  echo "> container already exists, rebuilding"
  docker stop postgres > /dev/null
  docker rm postgres > /dev/null
}
function createDocker() {
  if [ "$( docker ps -a | grep -c postgres )" -gt 0 ]; then
    removeOldDocker
  fi
    docker run -it -d -p 5432:5432 -v pgdata:/var/lib/postgres/data -e POSTGRES_PASSWORD="$POSTGRESPROJECT_DATABASE_PASSWORD" --name postgres postgres:13.2-alpine
    echo "> container running"
}
function installDockerIfNeeded() {
    if ! command -v "docker" &> /dev/null
    then
      echo "> docker could not be found, installing it first"
      ./setup_docker
    exit
	fi
}
function readInPassword() {
  echo "> give a password that you want to run on : "
  read -r POSTGRESPROJECT_DATABASE_PASSWORD
}
function readInPasswordIfNeeded() {
  if [ -z "$POSTGRESPROJECT_DATABASE_PASSWORD" ]
  then
    readInPassword
    printInfo=1
  else
    printInfo=0
  fi
}
function printEnvInfo() {
  if [ $printInfo -gt 0 ]; then
    echo '> WARNING PASSWORD NOT IN ENVIRONMENT! '
    echo '> add this to your enviroment: '
	  echo "    -> export POSTGRESPROJECT_DATABASE_PASSWORD=\"${POSTGRESPROJECT_DATABASE_PASSWORD}\""
  fi
  echo "> done"
}

stop_local_postgres_server_if_running
installDockerIfNeeded
readInPasswordIfNeeded
createDocker
printEnvInfo