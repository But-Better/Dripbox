#!/bin/bash

if ! [ "$(docker inspect -f {{.State.Running}} postgres)" == "true" ]; then
  echo "docker not running"
  echo "starting docker"
  ./run_local_docker
fi

echo "creating db..."
rails db:create
echo "migrating schema..."
rails db:migrate

echo "done"