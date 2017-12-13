FROM debian:stretch-slim

#####################
# Update the system #
#####################
RUN apt-get update && \
    apt-get dist-upgrade -y


#######################
# Install docker #
#######################
RUN apt-get install -y \
     apt-transport-https \
     ca-certificates \
     curl \
     gnupg2 \
     software-properties-common

RUN curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | apt-key add - \
	echo "deb [arch=armhf] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
    $(lsb_release -cs) stable" | \
    tee /etc/apt/sources.list.d/docker.list \
	apt-get update \
	apt-get install docker-ce   

#######################
# Install supervisord #
#######################
RUN apt-get install -y supervisor python-pip && \
    pip install supervisor-stdout && \
    mkdir -p /var/log/supervisor && \
    echo " \
    /etc/init.d/supervisor start" >> /etc/bash.bashrc

ADD config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

CMD ["/bin/bash"]