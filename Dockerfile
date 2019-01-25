FROM debian:wheezy

MAINTAINER Fabrizio Galiano 'fabrizio.galiano@hotmail.com'
LABEL description='BIND DNS Server with Webmin Gui'

ENV DATA_DIR=/data \
    BIND_USER=bind \
    WEBMIN_VERSION=1.900

RUN rm -rf /etc/apt/apt.conf.d/docker-gzip-indexes && apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y vim wget bind9 perl libnet-ssleay-perl openssl \
      libauthen-pam-perl libpam-runtime libio-pty-perl dnsutils apt-utils \
      apt-show-versions python \
 && wget --no-check-certificate "https://sourceforge.net/projects/webadmin/files/webmin/${WEBMIN_VERSION}/webmin_${WEBMIN_VERSION}_all.deb" -P /tmp/ \
 && dpkg -i /tmp/webmin_${WEBMIN_VERSION}_all.deb \
 && rm -rf /tmp/webmin_${WEBMIN_VERSION}_all.deb \
 && rm -rf /var/lib/apt/lists/*

COPY scripts/ /scripts/
RUN chmod 755 /scripts/ -R

EXPOSE 53/udp 53/tcp 10000/tcp
VOLUME ["${DATA_DIR}"]
ENTRYPOINT ["/scripts/entrypoint.sh"]
CMD ["/usr/sbin/named"]
