#!/bin/sh
# Ubuntu 20.04LTS headless noVNC
# Connect to http://localhost:6080/
REPO=fredblgr/
IMAGE=docker-framac
TAG=2021

if [[ -z $SUDO_UID ]]
then
  # not in sudo
  USER_ID=`id -u`
  USER_NAME=`id -n -u`
else
  # in a sudo script
  USER_ID=${SUDO_UID}
  USER_NAME=${SUDO_USER}
fi

if [[ `uname` == "Darwin" ]]
then
  open -a XQuartz
fi

if [[ -z $SUDO_UID ]]
then
  xhost +localhost
else
  su ${USER_NAME} -c 'xhost +localhost'
fi

docker run --rm --tty --interactive \
  --volume ${PWD}:/workspace:rw \
  --env USERNAME=${USER_NAME} --env USERID=${USER_ID} \
  --env DISPLAY="host.docker.internal:0" \
  --workdir /workspace \
  --name ${IMAGE} \
  ${REPO}${IMAGE}:${TAG}

