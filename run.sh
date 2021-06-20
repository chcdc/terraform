#!/bin/bash

IMAGE=chcdc/infra-terraform

OS_USER=infra
INFRASTRUCTURE_VOLUME_PATH=/copy/infrastructure:ro
CONFIG_VOLUME_PATH=/copy/config:ro

docker build . -t ${IMAGE} \
  --build-arg USER_ID=$(id -u) \
  --build-arg GROUP_ID=$(id -g)

#docker push chcdc/infra-terraform
#docker rmi -f $(docker images -f "dangling=true" -q)

docker run --rm -it --name infra-$(date +%F--%H-%M-%S)--$(uuidgen) \
  -v $HOME:/host/home \
  -v $(realpath /etc/localtime):/etc/localtime:ro \
  -v $(pwd):$INFRASTRUCTURE_VOLUME_PATH \
  -v $(pwd):/infra/Develop \
  ${IMAGE}
