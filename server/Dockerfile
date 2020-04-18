FROM rabbitmq:3.5.7-management

MAINTAINER "Thomas Mildner"

ENV RABBITMQ_USER user
ENV RABBITMQ_PASSWORD user

COPY rabbitmq.config /etc/rabbitmq/
COPY custom_definitions.json /etc/rabbitmq/

CMD ["rabbitmq-server"]



