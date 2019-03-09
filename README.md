# Preconfigure RabbitMQ using a Custom Docker Container

As is, this project creates a custom docker container for RabbitMQ with a preconfigured vhost (example-vhost), exchange (example-exchange), and queue (example-queue) with appropriate bindings therein.

You can use this project to create your own pre-configured RabbitMQ image and container that you setup either by

1. directly modifying the included custom_definitions.json configuration file with a text editor, or by
2. (**recommended**) using the RabbitMQ management interface to create the vhosts, exchanges, queues, and bindings that you want, and then exporting the resulting configuration to overright the included custom_definitions.json file.

The following instructions explain how to run the RabbitMQ server container, modify the included custom configuration using your web browser in the RabbitMQ management interface, and then export the resulting configuration to include your changes in a new custom RabbitMQ server image and container.

## Getting Started

We have two docker containers in this example:

1. **repo/rabbitmq-example-server** = This is the server we want, pre-configured with vhost, exchange, and queue.
2. repo/rabbitmq-example-client = This is another instance of rabbitmq "linked" to the above server container so that we can run the rabbit command line interfaces (cli's) against the server.

Start in the root directory of this project, then

#### Step-1:

Build and run the RabbitMQ server container:

```bash
./build_server.sh
./run_server.sh
```

You should see a running container in Docker that looks something like the following:

```bash
docker ps
```

```
CONTAINER ID        IMAGE                                 COMMAND                  CREATED             STATUS              PORTS                                                                     NAMES
9b885d5e8391        repo/rabbitmq-example-server:latest   "/docker-entrypoint.s"   31 minutes ago      Up 31 minutes       4369/tcp, 5671-5672/tcp, 15671/tcp, 25672/tcp, 0.0.0.0:15672->15672/tcp   rabbitmq-example-server
```

#### Step-2:

Use the management interface with your web browser to setup RabbitMQ for your environment.

If the server container is running, you should be able to reach the RabbitMQ management interface in your web browser on localhost as follows: [http://localhost:15672/]().

* Username: `admin`
* Password: `nimda`

> Note, however, that if you are using **docker-machine** instead of running docker natively, you will need to know the ip address of the running machine vm (instead of localhost). Most people run a docker-machine named 'default', and can therefore get the IP as follows:
>  ```docker-machine ip default```
> On my computer, this resolved to 192.168.99.100, which means I would access the RabbitMQ management interface with the following address: [http://192.168.99.100:15672/]()

#### Step-3:

Once you are happy with the configuration in RabbitMQ, you can use the included client Docker container to export the new configuration.

Build and run the RabbitMQ client container:

```bash
./build_client.sh
./run_client.sh
```
This should bring you to a bash command prompt for the client container.

#### Step-4:

In the bash prompt for the client container from the prior step, export the current configuration of the rabbitmq-example-server:

```bash
rabbitmqadmin --host rabbitmq-example-server --username admin --password nimda export custom_definitions.json
```

View the contents of the resulting file:

```bash
cat custom_definitions.json
```

The results are not formatted nicely (all on one line), and they look something like this:

```json
{"rabbit_version":"3.5.7","users":[{"name":"admin","password_hash":"b/XedHeZ8AVWttrmlrs5Mjl+eKI=","tags":"administrator"}],"vhosts":[{"name":"/"},{"name":"example-vhost"}],"permissions":[{"user":"admin","vhost":"/","configure":".*","write":".*","read":".*"},{"user":"admin","vhost":"example-vhost","configure":".*","write":".*","read":".*"}],"parameters":[],"policies":[],"queues":[{"name":"example-queue","vhost":"example-vhost","durable":true,"auto_delete":false,"arguments":{"x-max-length":5}}],"exchanges":[{"name":"example-exchange","vhost":"example-vhost","type":"fanout","durable":true,"auto_delete":false,"internal":false,"arguments":{}}],"bindings":[{"source":"example-exchange","vhost":"example-vhost","destination":"example-queue","destination_type":"queue","routing_key":"","arguments":{}}]}
```

You can use the above output to overright the included file in server/custom_definitions.json. 
> You might also want to use a nice json editor like Netbeans to format the output before pasting into server/custom_definitions.json

Exit the client container:

```bash
exit
```

#### Step-5:

Back in the root of this project, cleanup the old containers:

```bash
./cleanup.sh
```

You can rebuild and re-run the server container (see step #1 above) and then connect to it in with your web browser (see step #2 above) to verify that your custom configurations have worked.

#### Step-6:

Make any edits you like to run_server.sh and server/Dockerfile to reflect your organization. You might also want to publish your resulting server image on DockerHub and/or in a private Docker repository.

## Server usage

```bash
./build_server.sh
./run_server.sh [debug]
```
The management console should be running on port 15672. The base URL differs depending on your environment:

* If you are running docker natively, you can access the management console from here: [http://localhost:15672/](http://localhost:15672/)
* If you are running in docker-machine, and you are using "default" as the machine name, you can use the following command to show the URL for the management console:

   ```echo "http://$(docker-machine ip default):15672/"```

## Client usage

```bash
./build_client.sh
./run_client.sh
```

Export the current configuration of the rabbitmq-example-server:

```bash
rabbitmqadmin --host rabbitmq-example-server --username admin --password nimda export custom_definitions.json
```

## Contributing

1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request.

## History

1. January 3, 2016 -- initial version.
2. March 9, 2019 -- cleanup README, add shebang, other consmetic stuff.

## Background Story

I couldn't make a custom rabbitmq image work with preconfigured vhost/exchange/queue just by following the steps on the blog post here: [Creating a custom RabbitMQ container with preconfigured queues](http://devops.datenkollektiv.de/creating-a-custom-rabbitmq-container-with-preconfigured-queues.html). That post had two problems:

1. In **rabbitmq.config**, they put quotes around the labels (e.g., "load_definitions", vs load_definitions,) and that didn't work,
2. I was trying to run the custom container with "docker run" paremters such as "-e RABBITMQ_DEFAULT_USER=admin", but specifying that parameter generates a new rabbitmq.config that overwrites the one I was trying to put in place. I suspect this is a feature/bug of the underlying rabbitmq image implementation.

I figured out the above through trial-and-error and many Google searches. I hope this example helps save you time improving on my attempts.

## License

Gratis and libre.