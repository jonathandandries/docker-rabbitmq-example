docker run -it \
  --rm \
  --name rabbitmq-example-client \
  --link rabbitmq-example-server \
  -e RABBITMQ_ERLANG_COOKIE='example secret' \
  -e RABBITMQ_NODENAME=rabbit@rabbitmq-example-server \
  repo/rabbitmq-example-client
