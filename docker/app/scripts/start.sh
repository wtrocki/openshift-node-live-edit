#!/bin/bash

PATH=$PATH:./node_modules/.bin

if [ ! -z $NODE_LIVE_EDIT ]; then
    echo "Starting node server in live edit mode"
    forever --watch index.js .
elif [ ! -z $NODE_APP_DEBUG ]; then
    echo "Starting node server in debug mode"
    node debug index.js
else
    echo "Starting node server"
    node index.js 
fi
