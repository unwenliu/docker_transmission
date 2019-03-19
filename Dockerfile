FROM alpine:latest

ENV TRANSMISSION_WEB_VERSION 1.6.0-beta2
ENV USERNAME admin
ENV PASSWORD admin


RUN apk update \
    && apk add --no-cache transmission-daemon \
    && rm -rf /usr/share/transmission/web/* \
    && cd /tmp \
    && wget https://github.com/ronggang/transmission-web-control/archive/v${TRANSMISSION_WEB_VERSION}.tar.gz \
    && tar zxf v${TRANSMISSION_WEB_VERSION}.tar.gz \
    && cp -r transmission-web-control-${TRANSMISSION_WEB_VERSION}/src/* /usr/share/transmission/web/ \
    && rm -rf /var/cache/apk/* /tmp/*

EXPOSE 9091 51413
VOlUME /data

ENTRYPOINT ["/usr/bin/transmission-daemon","--cofnig-dir=/data/config","--port=9091","--peerport=51413","--username=${USERNAME}","--password=${PASSWORD}"]
