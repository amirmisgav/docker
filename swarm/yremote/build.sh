#!/bin/bash

#DOCKER_REGISTRY=dreg.tikalknowledge.com:5000
DOCKER_REGISTRY=54.200.21.126:5000
WORKSPACE=${PWD}
echo "WORKSPACE=$WORKSPACE"


YR_VERSION=$1
echo "YR_VERSION=$YR_VERSION"


echo "Build ynginx image for version ${YR_VERSION}"
cd ${WORKSPACE}/ynginx
docker build -t ${DOCKER_REGISTRY}/yremote/ynginx:${YR_VERSION} .
docker push ${DOCKER_REGISTRY}/yremote/ynginx:${YR_VERSION}
docker tag -f ${DOCKER_REGISTRY}/yremote/ynginx:${YR_VERSION} ${DOCKER_REGISTRY}/yremote/ynginx:latest-not-tested
docker push ${DOCKER_REGISTRY}/yremote/ynginx:latest-not-tested
echo
echo "Build yremote image for version ${YR_VERSION}"
cd ${WORKSPACE}/yremote
docker build -t ${DOCKER_REGISTRY}/yremote/yremote:${YR_VERSION} .
docker push ${DOCKER_REGISTRY}/yremote/yremote:${YR_VERSION}
docker tag -f ${DOCKER_REGISTRY}/yremote/yremote:${YR_VERSION} ${DOCKER_REGISTRY}/yremote/yremote:latest-not-tested
docker push ${DOCKER_REGISTRY}/yremote/yremote:latest-not-tested



