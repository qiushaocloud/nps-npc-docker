ARG NPS_VERSION=v0.26.10
FROM alpine:latest
LABEL author="qiushaocloud"
LABEL site="https://www.qiushaocloud.top"
LABEL email="qiushaocloud@126.com"

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
    && apk update \
    && apk add -U tzdata wget \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

RUN mkdir -p /tmp-download-dir \
    && wget https://github.com/ehang-io/nps/releases/download/${NPS_VERSION}/linux_amd64_server.tar.gz -O /tmp-download-dir/linux_amd64_server.tar.gz

COPY bootstarp.sh /usr/bin/bootstarp.sh

RUN cd /tmp-download-dir \
    && tar -zxvf linux_amd64_server.tar.gz \
    && cd linux_amd64_server \
    && chmod +x /usr/bin/bootstarp.sh \
    && chmod +x nps \
    && ./nps install \
    && cd / \
    && rm -rf /tmp-download-dir \
    && rm /usr/bin/nps-update

CMD ["bootstarp.sh"]