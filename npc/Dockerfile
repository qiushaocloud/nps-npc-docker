FROM alpine:latest
LABEL author="qiushaocloud"
LABEL site="https://www.qiushaocloud.top"
LABEL email="qiushaocloud@126.com"

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
    && apk update \
    && apk add -U tzdata wget \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

COPY bootstarp.sh /usr/bin/bootstarp.sh
COPY linux_amd64_client.tar.gz /tmp-download-dir/linux_amd64_client.tar.gz

RUN cd /tmp-download-dir \
    && tar -zxvf linux_amd64_client.tar.gz \
    && cd linux_amd64_client \
    && mkdir -p /etc/npc \
    && cp -ra ./conf /etc/npc/ \
    && chmod +x /usr/bin/bootstarp.sh \
    && chmod +x npc \
    && ./npc install \
    && cd / \
    && rm -rf /tmp-download-dir \
    && rm /usr/bin/npc-update

CMD ["bootstarp.sh"]