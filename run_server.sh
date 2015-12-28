#!/bin/bash
if [[ debug != "$1" ]]; then
  echo () { :; }
  shift
fi

IMAGE="repo/rabbitmq-example-server"
TAG="latest"
CONTAINER="rabbitmq-example-server"

#############################################
# 
# Start the rabbitmq-example-server, but only if it is not already started.
#
# This script was inspired by check_docker_container.sh found here:
#   https://gist.github.com/ekristen/11254304
#
# - Jonathan D'Andries, 12/28/2015
#
#############################################

RUNNING=$(docker inspect --format="{{ .State.Running }}" $CONTAINER 2> /dev/null)

if [ $? -eq 1 ]; then
  echo "Initializing ${CONTAINER}..."
  #The following two are handled by at build-time with rabbit.config
  # If we use them hear, it will overright rabbit.config.
  # - Jonathan D'Andries, 12/26/2015
  #  -e RABBITMQ_DEFAULT_USER=admin \
  #  -e RABBITMQ_DEFAULT_PASS=nimda \
  docker run -d \
    --hostname $CONTAINER \
    --name $CONTAINER \
    -p 8080:15672 \
    -e RABBITMQ_ERLANG_COOKIE='example secret' \
    ${IMAGE}:${TAG}
fi

if [ "$RUNNING" == "false" ]; then
  echo "(Re)starting ${CONTAINER}..."
  docker start $CONTAINER
fi

STARTED=$(docker inspect --format="{{ .State.StartedAt }}" $CONTAINER)
NETWORK=$(docker inspect --format="{{ .NetworkSettings.IPAddress }}" $CONTAINER)
CONTAINER_ID=$(docker inspect --format="{{ .Id }}" $CONTAINER)

echo -e "OK - $CONTAINER is running. \n  IP: $NETWORK\n  CONTAINER ID: $CONTAINER_ID\n  StartedAt: $STARTED"
