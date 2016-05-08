#!/bin/bash

if [ -z "$DOCKER_EMAIL" ] || [ -z "$DOCKER_USER" ] || [ -Z "$DOCKER_PASSWORD" ] ; then
    echo "Please set Docker credentials"
    exit 2;
fi

docker login -e $DOCKER_EMAIL -u $DOCKER_USER -p $DOCKER_PASS

# Build MongoDB Docker image
(
	cd mongodb
	docker build -t udaysagar/smacrobs_mongo:latest .
	docker push udaysagar/smacrobs_mongo
)

# Build smacrobs_website Docker image
(
        rm -rf adenosine
	git clone https://github.com/ceeeni/adenosine --branch dev-uday
	cd adenosine
	docker build -t udaysagar/smacrobs_website:latest .
	docker push udaysagar/smacrobs_website
        rm -rf adenosine
)
