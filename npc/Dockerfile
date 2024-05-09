FROM alpine:latest
LABEL author="qiushaocloud"
LABEL site="https://www.qiushaocloud.top"
LABEL email="qiushaocloud@126.com"

ENV NPC_VERSION=v0.26.10

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
    && apk update \
    && apk add -U tzdata wget \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

COPY bootstarp.sh /bootstarp.sh
COPY linux_amd64_client.tar.gz /tmp-download-dir/linux_amd64_client.tar.gz

RUN cd /tmp-download-dir \
    && mkdir -p linux_amd64_client \
    && tar -zxvf linux_amd64_client.tar.gz -C linux_amd64_client \
    && cd linux_amd64_client \
    && mkdir -p /etc/npc \
    && cp -ra ./conf /etc/npc/ \
    && chmod +x /bootstarp.sh \
    && chmod +x npc \
    && ./npc install \
    && cd / \
    && rm -rf /tmp-download-dir \
    && rm /usr/bin/npc-update

CMD ["sh", "/bootstarp.sh"]