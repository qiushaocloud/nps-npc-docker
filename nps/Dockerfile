ARG NPS_VERSION=v0.26.10
FROM alpine:latest
LABEL author="qiushaocloud"
LABEL site="https://www.qiushaocloud.top"
LABEL email="qiushaocloud@126.com"

RUN apk update \
    && apk add -U tzdata wget \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

RUN wget https://github.com/ehang-io/nps/releases/download/${NPS_VERSION}/linux_amd64_server.tar.gz -O /var/tmp/linux_amd64_server.tar.gz

RUN cd /var/tmp/ \
    && mkdir nps \
    && tar -zxvf linux_amd64_server.tar.gz -C nps \
    && cd nps \
    && ./nps install \
    && cd ../ \
    && rm -rf nps/ \
    && rm linux_amd64_server.tar.gz \
    && rm /usr/bin/nps-update

CMD ["nps"]