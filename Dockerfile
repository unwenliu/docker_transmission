FROM alpine:3.8

# 设置中科大源
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories

# 安装软件
RUN apk update \
    && apk add --no-cache git transmission-daemon \
    && rm -rf /usr/share/transmission/web/* \
    && mkdir -p /data/.watch /data/.config /data/downloads \
    && cd /tmp \
    && git clone https://github.com/ronggang/transmission-web-control.git \
    && cp -r transmission-web-control/src/* /usr/share/transmission/web/ \
    && rm -rf /var/cache/apk/* /tmp/*

copy settings.json /etc/transmission/settings.json

EXPOSE 9091 51413/tcp 51413/udp
VOLUME /data/downloades

ENTRYPOINT ["/usr/bin/transmission-daemon","--foreground","--config-dir","/etc/transmission"]
