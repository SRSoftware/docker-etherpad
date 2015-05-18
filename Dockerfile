FROM ubuntu:trusty
MAINTAINER Arcus "http://arcus.io"
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y wget nodejs npm gzip git-core curl python libssl-dev pkg-config build-essential supervisor
RUN cd /usr/bin && ln -s nodejs node
RUN (cd /opt && git clone git://github.com/ether/etherpad-lite.git etherpad)
RUN (cd /opt/etherpad && ./bin/installDeps.sh)
ADD settings.json /opt/etherpad/settings.json
ADD supervisor.conf /etc/supervisor/supervisor.conf

EXPOSE 9001
CMD ["supervisord", "-c", "/etc/supervisor/supervisor.conf", "-n"]
