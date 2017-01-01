## OpenShift Live Edit and Debugger

Live edit and debug your OpenShift node.js applications without building docker images.

![](http://i.giphy.com/l4JyN1r2FMpLpgj16.gif)

Edit your files within your node.js app and all changes would automatically synced with your instance in cloud.

## How to run demo

Login to cluster

    oc login 

Select project you want to use

    oc project your-project
    
Create app from template 
   
    oc new-app ./openshift/node-live-edit.json

Configure watch 

    oc rsync --watch --no-perms=true --exclude=./docker/app/node_modules ./docker/app/ your_pod_name:/opt/app/
 
Now all your changes would be synchronized with the pod. If you do not wish to synchronize every time file is saved remove `watch` option. To update node_modules remove `--exclude` from command(this will affect initial sync performance)

## How live edit works

If `NODE_LIVE_EDIT` environment variable is set image would use forever to monitor files located in app directory.
Files from local machine are send using rsync to the container. 
Once file is changed in the container forever would detect this change and restart process.
Live edit works thanks to customized image. See `Dockerfile` for more info.

Depending on network speed update may take from 2 to 10 seconds.
You can sync more than one container at the time.

## Making it more generic

Following example is using forever, but we can use any other process manager or other live reloading solutions. 
Another good example would be to run `grunt watch` command, but this would require dev dependencies to be installed in the image. 

## Debugging 

If `NODE_APP_DEBUG` variable is set node process would run in debug mode.
By default debugger starts on port `5858`. 
To connect with any local machine debugger we would need to forward local port to the container using command

    oc port-forward <pod> :5858

> *Note:* You may need to change or remove liveness and readiness probes to avoid killing pod when debugging.

## Alternatives to custom entrypoint

Instead of using bash script as entrypoint we can change OpenShift deployment config as bellow:

        command: [ "node", "--debug-brk", "index.js" ]
        

## Variables

> NODE_LIVE_EDIT

Set to true to live edit and reload your app

> NODE_APP_DEBUG

Set to true to debug your app

# Notes

Created just for demo purposes. Do not use this in production :)
Example shows how to sync node.js apps but rsync and forever are generic enough to use them with any other technology. I used similar approach to live reload archives and binary files. 
