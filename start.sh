#!/bin/bash

function stop_and_remove_container(){
  if [[ $(docker ps -a | grep -w "$1" | grep -Ev "grep") ]]; then
    echo "killing currently running $1"
    docker rm -f $1
  fi
}

stop_and_remove_container "dynamodb_local"
docker build -t dynamodb dynamodb/
docker run -d -p 8000:8000 --name "dynamodb_local" -v $(pwd)/dynamodb/dynamodb_data:/dynamodb_data dynamodb
