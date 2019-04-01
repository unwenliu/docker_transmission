FROM alpine:3.8

ENV TRANSMISSION_WEB_VERSION 1.6.0-beta2
ENV USERNAME admin
ENV PASSWORD admin


# 设置中科大源
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories

# 安装软件
RUN apk update \
    && apk add --no-cache transmission-daemon \
    && mkdir -p /data/.config /data/.watch /data/downloads \
    && rm -rf /usr/share/transmission/web/* \
    && cd /tmp \
    && wget https://github.com/ronggang/transmission-web-control/archive/v${TRANSMISSION_WEB_VERSION}.tar.gz \
    && tar zxf v${TRANSMISSION_WEB_VERSION}.tar.gz \
    && cp -r transmission-web-control-${TRANSMISSION_WEB_VERSION}/src/* /usr/share/transmission/web/ \
    && rm -rf /var/cache/apk/* /tmp/*

copy settings.json /etc/transmission/settings.json

EXPOSE 9091 51413/tcp 51413/udp
VOLUME /data

ENTRYPOINT ["/usr/bin/transmission-daemon","--foreground","--config-dir","/etc/transmission","--username","${USERNAME}","--password","${PASSWORD}"]
