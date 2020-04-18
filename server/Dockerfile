FROM rabbitmq:3.5.7-management

MAINTAINER "Thomas Mildner"

ADD rabbitmq.config /etc/rabbitmq/
ADD custom_definitions.json /etc/rabbitmq/

CMD ["rabbitmq-server"]



