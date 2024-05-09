# NPC Client（即 NPS 客户端）

nps是一款轻量级、高性能、功能强大的**内网穿透**代理服务器。目前支持**tcp、udp流量转发**，可支持任何**tcp、udp**上层协议（访问内网网站、本地支付接口调试、ssh访问、远程桌面，内网dns解析等等……），此外还**支持内网http代理、内网socks5代理**、**p2p等**，并带有功能强大的web管理端。

**参考 [NPS GitHub](https://github.com/ehang-io/nps) 代码仓库 和 [官方文档](https://ehang-io.github.io/nps)**


### 客户端启动（npc）
* Docker 部署
  `docker run -d --name qiushaocloud-npc-client --net=host -v ./conf:/etc/npc/conf qiushaocloud/npc-client:latest`
* Docker Compose 部署，[docker-compose.yaml 文件](https://github.com/qiushaocloud/nps-npc-docker/tree/master/npc/docker-compose.yaml)
  ```yaml
  version: "3"
  services:
    qiushaocloud-npc-client:
      image: qiushaocloud/npc-client:latest
      container_name: qiushaocloud-npc-client
      network_mode: "host"
      restart: always
      volumes: 
        - ./conf:/etc/npc/conf:rw
        #- /tmp/npcDownload:/tmp/npcDownload:rw
      environment:
        - TZ=Asia/Shanghai
        - RERUN_MAX_NPC_CPU=110 # 如果配置了该值，则会在客户端启动时，根据CPU使用率自动重启客户端，防止CPU过高导致客户端卡死
      #ports:
      #  - "8000:8000"
      #  - "8080:8080/udp"
      #  - "8081:8081"
      #  - "80:80"
      #  - "443:443"
      #  - "22:22"
      #  - "3306:3306"
      #  - "6379:6379" 
  ```
* NPC Config Download: [客户端配置](https://github.com/qiushaocloud/nps-npc-docker/tree/master/npc/conf)
