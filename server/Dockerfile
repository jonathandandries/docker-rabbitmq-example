FROM rabbitmq:3.5.7-management

MAINTAINER Jonathan D'Andries

COPY rabbitmq.config /etc/rabbitmq/
COPY definitions.json /etc/rabbitmq/

CMD ["rabbitmq-server"]
