#!/bin/bash
set -xe

function stop_and_remove_container(){
  if [[ $(docker ps -a | grep -w "$1" | grep -Ev "grep") ]]; then
    echo "killing currently running $1"
    docker rm -f $1
  fi
}

stop_and_remove_container "mongodb"
docker run -d \
    -p 27017:27017 \
    --name mongodb \
    -v $(pwd)/mongo_data/data:/data/db \
    -v $(pwd)/mongo_data/configdb:/data/configdb \
    mongo