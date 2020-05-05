FROM rabbitmq:3.8.3

MAINTAINER "Jonathan D'Andries"

RUN mkdir -p /etc/bash_completion.d/ \
	&& apt-get update && apt-get install -y --no-install-recommends \
		python \
		bash-completion \
	&& rm -rf /var/lib/apt/lists/*

# The following file was downloaded from the running instance
# of rabbitmq:3.8.3-management using the url:
# http://{server}:{managementport}/cli/rabbitmqadmin 
# e.g., http://192.168.99.100:15672/cli/rabbitmqadmin
COPY rabbitmqadmin /usr/local/bin/rabbitmqadmin

ENV HOME /root
# Calling "; sync" in the following command because we get the following
# error without it:
#     /bin/sh: 1: rabbitmqadmin: Text file busy
# More info here: https://github.com/docker/docker/issues/9547
RUN chmod 755 /usr/local/bin/rabbitmqadmin; sync \
	&& rabbitmqadmin --bash-completion > /etc/bash_completion.d/rabbitmqadmin \
	&& echo "source /etc/bash_completion.d/rabbitmqadmin" >> ~/.bashrc

CMD [ "/bin/bash" ]
