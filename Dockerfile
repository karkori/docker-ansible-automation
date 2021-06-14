FROM ubuntu:20.04

ENV PORT=8080
ENV TZ=Europe/Minsk
ENV PASS=root

RUN su && echo "$PASS\n$PASS\n" | passwd "root"

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get update \
    && apt-get -y install \
        git \
        docker.io \
        openssh-server \
        net-tools \
        vim \
        sudo \
    && mkdir -p ~/.ssh \
    && chmod 700 ~/.ssh \
    && touch ~/.ssh/authorized_keys \
    && chmod 600 ~/.ssh/authorized_keys \
    && /etc/init.d/ssh start \
    && service ssh start \
    && dockerd&

# Config ssh and restart the service
RUN grep -qxF 'PermitRootLogin yes' /etc/ssh/sshd_config || echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config \
    && service ssh restart

# expose port
EXPOSE $PORT
