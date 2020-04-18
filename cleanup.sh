#!/usr/bin/env sh
docker rm $(docker stop vvss20-rabbitmq-server)
docker rmi vvss20-rabbitmq-server

