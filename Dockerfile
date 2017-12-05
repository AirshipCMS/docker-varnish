FROM        debian:jessie
MAINTAINER  Jon Borgonia "jon@gomagames.com"

ENV DEBIAN_FRONTEND noninteractive

# Update the package repository and install applications
RUN apt-get update && \
    apt-get install -y apt-transport-https curl debian-archive-keyring gnupg && \
    curl -L https://packagecloud.io/varnishcache/varnish41/gpgkey | apt-key add - && \
    echo "deb https://packagecloud.io/varnishcache/varnish41/debian/ jessie main\ndeb-src https://packagecloud.io/varnishcache/varnish41/debian/ jessie main" >> /etc/apt/sources.list.d/varnishcache_varnish41.list
RUN apt-get update && \
    apt-get install -y varnish && \
    rm -rf /var/lib/apt/lists/*

ENV VARNISH_PORT 80
ENV VARNISH_MEM 256M
ENV HOST_IP 0.0.0.0
ENV ETCD_PORT 2379

# Expose port 80
EXPOSE 80

ADD default.vcl /etc/varnish/default.vcl
ADD default.varnish.env /etc/default/varnish

ADD docker-entrypoint.sh /
ENTRYPOINT ["/bin/sh", "/docker-entrypoint.sh"]

# Expose volumes to be able to use data containers
# VOLUME ["/var/lib/varnish", "/etc/varnish"]

CMD ["/etc/init.d/varnish", "start"]
