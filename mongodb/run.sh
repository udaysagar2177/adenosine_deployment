#!/bin/bash
set -x

# start mongodb server
mongod & > /tmp/mongod_status

sleep 10

# insert recommendations data
curl $RECOMMENDATIONS_DATA_GIST_URL > recommendations.js
mongo $DATABASE_NAME recommendations.js

tail -f /tmp/mongod_status