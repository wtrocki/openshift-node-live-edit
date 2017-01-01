#!/bin/bash

PATH=$PATH:./node_modules/.bin

if [ ! -z $NODE_LIVE_EDIT ]; then
    echo "Starting node server in live edit mode"
    exec forever --watch index.js .
elif [ ! -z $NODE_APP_DEBUG ]; then
    echo "Starting node server in debug mode"
    exec node --debug-brk index.js
else
    echo "Starting node server"
    exec node index.js 
fi
