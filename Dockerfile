FROM ubuntu:18.04

RUN apt-get update && apt-get install -y wget libboost-all-dev supervisor libnorm1

WORKDIR /root

RUN wget https://github.com/graft-project/GraftNetwork/releases/download/v1.9.2/GraftNetwork_1.9.2-ubuntu-18.04.x64.tar.gz && \
  wget https://github.com/graft-project/graft-ng/releases/download/v1.0.4/supernode.1.0.4.ubuntu-18.04.x64.tar.gz && \
  tar -zxvf GraftNetwork_1.9.2-ubuntu-18.04.x64.tar.gz  && \
  tar -zvxf supernode.1.0.4.ubuntu-18.04.x64.tar.gz && \
  mv GraftNetwork_1.9.2-ubuntu-18.04.x64 graftnetwork && \
  mv supernode.1.0.4.ubuntu-18.04.x64 supernode && \
  rm GraftNetwork_1.9.2-ubuntu-18.04.x64.tar.gz supernode.1.0.4.ubuntu-18.04.x64.tar.gz

VOLUME /root/.graft
VOLUME /wallet

COPY supervisord.conf /etc/supervisord.conf
COPY config.ini /root/supernode/config.ini

CMD /usr/bin/supervisord -c /etc/supervisord.conf
