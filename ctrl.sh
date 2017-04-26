#!/bin/bash 

CMD=$1
PROJECT_DIR=$(cd `dirname $0` && pwd)
PROJECT_NAME=cdwdpoc
NETWORK_NAME=${PROJECT_NAME}_internal

function build() {
 cd $PROJECT_DIR
 mvn clean install
}

function __listApps() {
 docker ps --format="{{.Names}}" | grep ${PROJECT_NAME}_app_ | sort
}

function runTest() {
 for i in $(seq 0 999999); do
  curl -H "Host: $PROJECT_NAME" --silent \
    "http://127.0.0.1:8080/index.html?ts=$(date +%S%N)" 1>/dev/null
  if [ "$?" != "0" ]; then
   echo -n "!";
  else
   echo -n ".";
  fi
 done
}

function start() {
 cd $PROJECT_DIR && docker-compose up -d
}

function stop() {
 cd $PROJECT_DIR && docker-compose down
}

function status() {
 cd $PROJECT_DIR && docker-compose ps
}

function __waitForAppUp() {
 local app=$1
 local exitCode=0
 for i in $(seq 0 10); do
  docker exec $app /home/app/check-if-up.sh
  exitCode=$?
  if [ "x0" = "x$exitCode" ]; then
   echo "up"
   return 0
  fi
  sleep 1
 done
 echo "down"
 return 1
}

function redeploy() {
 local oldAppsFile=$(mktemp)
 local newAppsFile=$(mktemp)
 __listApps > $oldAppsFile
 local apps=$(cat $oldAppsFile)
 local oldAppCount=$(cat $oldAppsFile | wc -l)
 local oldApp=""
 local newApp=""
 local app=""
 local i=0
 local newAppStatus=""
 for oldApp in $apps; do
  echo "Redeploying $oldApp..."
  __listApps > $oldAppsFile
  docker-compose scale app=$((oldAppCount+1))

  __listApps > $newAppsFile
  newApp=$(diff $oldAppsFile $newAppsFile | grep "^>" | perl -pe 's#^>\s*(.*)$#$1#g')
  echo -n "Waiting for $newApp to be up... "
  newAppStatus=$(__waitForAppUp $newApp)
  if [ "up" != "${newAppStatus}" ]; then
   echo "failed."
   exit 1
  else
   echo "$newAppStatus"
  fi
  echo -n "Stopping $oldApp... " 
  docker stop $oldApp 2>&1 >/dev/null 
  docker rm -f $oldApp 2>&1 >/dev/null
  echo "done"
 done

 rm $oldAppsFile $newAppsFile
}

function scale() {
 docker-compose scale app=$1
}

case $CMD in
 build|start|stop|status|redeploy|scale|runTest)
  $CMD $2
 ;;
 help|*)
  echo "$(basename $0) build|start|stop|status|redeploy|scale|runTest|help"
 ;;
esac
