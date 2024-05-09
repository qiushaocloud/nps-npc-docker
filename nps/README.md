# NPS Server（即 NPS 服务端）

nps是一款轻量级、高性能、功能强大的**内网穿透**代理服务器。目前支持**tcp、udp流量转发**，可支持任何**tcp、udp**上层协议（访问内网网站、本地支付接口调试、ssh访问、远程桌面，内网dns解析等等……），此外还**支持内网http代理、内网socks5代理**、**p2p等**，并带有功能强大的web管理端。

**参考 [NPS GitHub](https://github.com/ehang-io/nps) 代码仓库 和 [官方文档](https://ehang-io.github.io/nps)**


### 服务端启动（nps）
* Docker 部署
  `docker run -d --name qiushaocloud-nps-server --net=host -v ./conf:/etc/nps/conf qiushaocloud/nps-server:latest`
* Docker Compose 部署，[docker-compose.yaml 文件](https://github.com/qiushaocloud/nps-npc-docker/tree/master/nps/docker-compose.yaml)
  ```yaml
  version: "3"
  services:
    qiushaocloud-nps-server:
      image: qiushaocloud/nps-server:latest
      container_name: qiushaocloud-nps-server
      network_mode: "host"
      restart: always
      volumes: 
        - ./conf:/etc/nps/conf:rw
      environment:
        - TZ=Asia/Shanghai
        - RERUN_MAX_NPS_CPU=110 # 如果配置了该值，则会在服务端启动时，根据CPU使用率自动重启服务，防止CPU过高导致服务端卡死
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
* NPS Config Download: [服务端配置](https://github.com/qiushaocloud/nps-npc-docker/tree/master/nps/conf)
