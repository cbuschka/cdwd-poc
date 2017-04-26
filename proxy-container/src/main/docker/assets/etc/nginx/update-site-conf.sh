#!/bin/bash

function printTs() {
  date +"%Y-%m-%d %H:%M:%S    "
}

SCRIPT=$0
BASE_DIR=$(cd `dirname $SCRIPT` && pwd)

nodes="$*"
if [ -z "$nodes" ]; then
  nodes="localhost"
fi

nodes_config=""
for node in $nodes; do 
  nodes_config="server $node:8080; $nodes_config"
done

config=$(cat $BASE_DIR/conf.d/site.conf.template |sed -r 's/$/EOL/g')

echo $config | sed -r "s/__SERVERS__/${nodes_config}/g" | sed -r 's/EOL/\n/g' > $BASE_DIR/conf.d/site.conf
echo "$(printTs) INFO new backend status: $nodes_config"

/usr/sbin/nginx -s reload 2>/dev/null
