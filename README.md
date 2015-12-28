# RabbitMQ example

This example creates a custom RabbitMQ container with a preconfigured vhost (example-vhost), exchange (example-exchange), and queue (example-queue) with appropriate bindings therein.

We have two docker containers in this example:

1. repo/rabbitmq-example-server

   This is the server we want, pre-configured with vhost, exchange, and queue.

2. repo/rabbitmq-example-client

   This is another instance of rabbitmq "linked" to the above server container so that we can run the rabbit command line interfaces (cli's) against the server.

## Background Story

I couldn't make a custom rabbitmq image work with preconfigured vhost/exchange/queue just by following the steps on the blog post here: [http://devops.datenkollektiv.de/creating-a-custom-rabbitmq-container-with-preconfigured-queues.html](http://devops.datenkollektiv.de/creating-a-custom-rabbitmq-container-with-preconfigured-queues.html). They had two problems:
1. In rabbitmq.config, they put quotes around the labels (e.g., "load_definitions", vs load_definitions,) and that didn't work,
2. I was trying to run the custom container with "docker run" paremters such as "-e RABBITMQ_DEFAULT_USER=admin", but specifying that parameter generates a new rabbitmq.config that overwrites the one I was trying to put in place. I suspect this is a feature/bug of the underlying rabbitmq image implementation.

I figured out the above through trial-and-error and many Google searches. I hope this example helps save you time improving on my attempts.

## Server usage

```
./build_server.sh
./run_server.sh
```

## Client usage

```
./build_client.sh
./run_client.sh
```

Show the vhosts on the server
```
rabbitmqadmin --host rabbitmq-example-server --username admin --password nimda list vhosts
```
