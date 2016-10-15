# docker-bind-gui
[![](https://images.microbadger.com/badges/version/fabriziogaliano/docker-bind-gui.svg)](https://microbadger.com/images/fabriziogaliano/docker-bind-gui "Get your own version badge on microbadger.com") [![](https://images.microbadger.com/badges/image/fabriziogaliano/docker-bind-gui.svg)](https://microbadger.com/images/fabriziogaliano/docker-bind-gui "Get your own image badge on microbadger.com")

Docker Bind 1.9 image with Webmin 1.820 Interface

## Webmin Default Password

```
WebminPassword
```

## Available Configuration Parameters

* __GUIPWD_WEBMIN__: Specify your custom password for Webmin

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
