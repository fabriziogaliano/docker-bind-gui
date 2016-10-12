FROM debian:wheezy

MAINTAINER Fabrizio Galiano 'fabrizio.galiano@hotmail.com'
LABEL description='BIND DNS Server with Webmin Gui'

ENV DATA_DIR=/data \
    BIND_USER=bind \
    WEBMIN_VERSION=1.810

RUN rm -rf /etc/apt/apt.conf.d/docker-gzip-indexes && apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y vim wget bind9 perl libnet-ssleay-perl openssl \
      libauthen-pam-perl libpam-runtime libio-pty-perl dnsutils apt-utils \
      apt-show-versions python \
 && wget "http://prdownloads.sourceforge.net/webadmin/webmin_${WEBMIN_VERSION}_all.deb" -P /tmp/ \
 && dpkg -i /tmp/webmin_${WEBMIN_VERSION}_all.deb \
 && rm -rf /tmp/webmin_${WEBMIN_VERSION}_all.deb \
 && rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /sbin/entrypoint.sh
RUN chmod 755 /sbin/entrypoint.sh

EXPOSE 53/udp 53/tcp 10000/tcp
VOLUME ["${DATA_DIR}"]
ENTRYPOINT ["/sbin/entrypoint.sh"]
CMD ["/usr/sbin/named"]
