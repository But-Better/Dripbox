#!/bin/bash

if ! [ "$(docker inspect -f {{.State.Running}} postgres)" == "true" ]; then
  echo "docker not running"
  echo "starting docker"
  ./run_local_docker
fi

echo "resetting db..."
rails db:reset
rails db:create
echo "migrating schema..."
rails db:migrate

echo "done"