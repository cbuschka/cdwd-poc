#!/bin/bash

# generate initially
/etc/nginx/update-site-conf.sh $(docker ps --format "{{.Names}}" | grep cdwdpoc_app)

# listen to events and act
while read line; do
	/etc/nginx/update-site-conf.sh $(docker ps --format "{{.Names}}" | grep cdwdpoc_app)
done < <( docker events --filter=event=start --filter=event=stop)

exit 0 
