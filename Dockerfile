FROM        debian:jessie
MAINTAINER  Jon Borgonia "jon@gomagames.com"

ENV DEBIAN_FRONTEND noninteractive

# Update the package repository and install applications
RUN apt-get update && \
    apt-get install -y varnish && \
    rm -rf /var/lib/apt/lists/*

ENV VARNISH_PORT 80
ENV VARNISH_MEM 256M

# Expose port 80
EXPOSE 80

# install confd and watch script
ADD bin/* /usr/local/bin/
RUN chmod +x /usr/local/bin/*

# add confd templates
ADD confd /etc/confd

# Expose volumes to be able to use data containers
VOLUME ["/var/lib/varnish", "/etc/varnish"]

ADD start.sh /start.sh
CMD ["/start.sh"]