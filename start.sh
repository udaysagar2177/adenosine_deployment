#!/bin/bash

echo "Tip:"
echo "     Remove mongodb/mongodb_data/db/.mongodb_password_set if you"
echo "     are changing the password"

MONGODB_USER="adenosine"
MONGODB_PASS="abcdefghijkl"
MONGODB_DATABASE="adenosine"

function stop_and_remove_container(){
  if [[ $(docker ps -a | grep -w "$1" | grep -Ev "grep") ]]; then
    echo "killing currently running $1"
    docker rm -f $1
  fi
}

stop_and_remove_container "mongodb"
docker build -t mongodb mongodb/
docker run \
	-it \
	-e MONGODB_USER=${MONGODB_USER} \
	-e MONGODB_PASS=${MONGODB_PASS} \
	-e MONGODB_DATABASE=$MONGODB_DATABASE \
	-p 27017:27017 \
	-p 28017:28017 \
	-h "mongodb" \
	--name "mongodb" \
	-v $(pwd)/mongodb/mongodb_data/db:/data/db \
	mongodb