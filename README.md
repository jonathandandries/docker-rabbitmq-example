# VV SS20 - RabbitMQ MessageBus

## Usage

## Option 1: Docker Hub Usage

Pull Docker Image from Docker Hub

```bash
docker pull vvthromildner/vvss20_rabbitmq
```

Start Docker Container from Image

```bash
docker run -d --name rabbitmq-rest-exercise -p 15672:15672 vvthromildner/vvss20_rabbitmq
```

Now you can access your RabbitMQ Management UI via:
http://localhost:15672 

The Credentials are:
> User: guest
> Pass: guest

## Option 2: Build Container yourself

Clone Git Repository

```bash
git clone https://github.com/Thomas-Mildner/docker-rabbitmq-example.git
cd docker-rabbitmq-example
```

Build image

```bash
./build_server.sh
```

Run Container

```bash
./run_server.sh
```

Get Logs from Container

```bash
docker logs -f rabbitmq-rest-exercise
```