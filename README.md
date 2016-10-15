# docker-bind-gui
[![](https://images.microbadger.com/badges/version/fabriziogaliano/docker-bind-gui.svg)](https://microbadger.com/images/fabriziogaliano/docker-bind-gui "Get your own version badge on microbadger.com") [![](https://images.microbadger.com/badges/image/fabriziogaliano/docker-bind-gui.svg)](https://microbadger.com/images/fabriziogaliano/docker-bind-gui "Get your own image badge on microbadger.com")

Docker Bind 1.9 image with Webmin 1.820 Interface

## Webmin Default Login


* __USER__: root
* __PASSWORD__: WebminPassword


## Available Configuration Parameters

* __GUIPWD_WEBMIN__: Specify your custom password for Webmin

## Advanced Configuration for Bind

if you want allow DNS forwarding and Recursion change the allowed ip's on /bind/etc/named.conf.options, easly copy and paste like below:

```
options {
        directory "/var/cache/bind";

        // If there is a firewall between you and nameservers you want
        // to talk to, you may need to fix the firewall to allow multiple
        // ports to talk.  See http://www.kb.cert.org/vuls/id/800113

        // If your ISP provided one or more IP addresses for stable
        // nameservers, you probably want to use them as forwarders.
        // Uncomment the following block, and insert the addresses replacing
        // the all-0's placeholder.

        //========================================================================
        // If BIND logs error messages about the root key being expired,
        // you will need to update your keys.  See https://www.isc.org/bind-keys
        //========================================================================

        managed-keys-directory "/var/dynamic";

        dnssec-validation auto;

        allow-recursion { 192.168.1.0/24 192.168.10.0/24; 172.16.0.0/16; 10.0.0.0/16; };

        auth-nxdomain no;    # conform to RFC1035
        listen-on-v6 { any; };
        forwarders {
                8.8.8.8;
                8.8.4.4;
                };
};
```

## Quick Start

```
docker run -p 53:53/udp -p 53:53 -p 10000:10000 -d fabriziogaliano/docker-bind-gui
```

## Docker-Compose.yml

```
version: '2'
services:
    dns:
        image: fabriziogaliano/docker-bind-gui

        container_name: bind_dns_gui

        environment:
           GUIPWD_WEBMIN: custompassword

#        volumes:
#           - "./data/bind:/data/bind"
#           - "./var/cache:/var/cache/bind"
#           - "./var/dynamic:/var/dynamic"

        ports:
           - "53:53/udp"
           - "53:53"
           - "10000:10000"

        command: bash /scripts/changeWebminPassword.sh
```
