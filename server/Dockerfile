FROM rabbitmq:3.8.3-management

MAINTAINER "Thomas Mildner"

COPY rabbitmq.conf /etc/rabbitmq/
COPY custom_definitions.json /etc/rabbitmq/

CMD ["rabbitmq-server"]



