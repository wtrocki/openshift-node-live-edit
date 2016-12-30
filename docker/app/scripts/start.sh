#!/bin/bash

echo $NODE_LIVE_EDIT

if [ ! -z $NODE_LIVE_EDIT ]; then
    echo "Starting node server in live edit mode"
    node node_modules/forever/bin/forever start --watch index.js .
elif [ ! -z $NODE_APP_DEBUG ]; then
    echo "Starting node server in debug mode"
    node debug index.js
else
    echo "Starting node server"
    node index.js 
fi