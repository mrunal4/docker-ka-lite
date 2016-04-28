#name of container: docker-ka-lite
#versison of container: 0.1

FROM quantumobject/docker-baseimage:15.10
MAINTAINER Angel Rodriguez  "angel@quantumobject.com"

#add repository and update the container
#Installation of nesesary package/software for this containers...
RUN echo "deb http://archive.ubuntu.com/ubuntu `cat /etc/container_environment/DISTRIB_CODENAME`-backports main restricted " >> /etc/apt/sources.list \
    && echo "deb http://ppa.launchpad.net/learningequality/ka-lite/ubuntu `cat /etc/container_environment/DISTRIB_CODENAME` main " >> /etc/apt/sources.list \
    && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 3194DD81
RUN apt-get update && apt-get install -y -q  ka-lite \
                      && apt-get clean \
                      && rm -rf /tmp/* /var/tmp/*  \
                      && rm -rf /var/lib/apt/lists/*



#to add startup.sh to be runs the scripts during startup
RUN mkdir -p /etc/my_init.d
COPY startup.sh /etc/my_init.d/startup.sh
RUN chmod +x /etc/my_init.d/startup.sh

VOLUME /var/ka-lite/.kalite/content

#expose port for https service
EXPOSE 8008

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]
