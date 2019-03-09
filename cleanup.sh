#!/usr/bin/env sh
docker rm $(docker stop rabbitmq-example-server)
docker rmi repo/rabbitmq-example-server
docker rmi repo/rabbitmq-example-client
