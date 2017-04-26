# Continous Deployment with Docker (Proof of concept) [![Build Status](https://travis-ci.org/cbuschka/cdwdpoc.svg?branch=master)](https://travis-ci.org/cbuschka/cdwdpoc) [![MIT licensed](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/cbuschka/cdwdpoc/master/license)

This is a proof of concept to show how an app can be redeployed without service being interrupted. 

The setup consists of a HTTP gateway (nginx proxy within a docker container) which serves requests to multiple app instances via an internal docker network. The gateway container is informed about starting and stopping app instances via docker events and updates the gateway config on demand.

The app is deployed as a docker container connected to the internal network.

On redeployment a new app instance is started, the redeployer waits for the app instance to finish start up and an old app instance is terminated until all old app instances are replaced.

## Required prerequesites
* docker and docker-compose installed
* jdk 8 installed
* mvn 3.x installed

## Project Structure

## Modules
* app/ - a java spring boot webapp
* app-container/ - docker container serving app instances
* proxy-container/ - http gateway placed in front of apps

## Build

```
mvn clean install
```

## Control script

### Start the cluster
```
./ctrl.sh start
```

### Show cluster status
```
./ctrl.sh status
```

### Run tests on different console
```
./ctrl.sh runTest
```

### Scale up app instances
```
./ctrl.sh scale 5
```

### Redeploy
This command redeploy all app instances by 
* starting a new one,
* waiting for the new instance to finish startup
* and terminating an old instance.

```
./ctrl.sh redeploy
```

### Check cluster status
```
./ctrl.sh status
```

### Check output of tests
There may be no ! results.

### Shutdown cluster
```
./ctrl.sh stop
```

## License
Copyright (c) 2016 by Cornelius Buschka

[MIT License](license)
