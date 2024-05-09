# nps-npc-docker

#### 介绍
这是一个 nps/npc docker，nps是一款轻量级、高性能、功能强大的**内网穿透**代理服务器。目前支持**tcp、udp流量转发**，可支持任何**tcp、udp**上层协议（访问内网网站、本地支付接口调试、ssh访问、远程桌面，内网dns解析等等……），此外还**支持内网http代理、内网socks5代理**、**p2p等**，并带有功能强大的web管理端。

#### 背景
![image](https://githubcdn.qiushaocloud.top/gh/ehang-io/nps@master/image/web.png?raw=true)

1. 做微信公众号开发、小程序开发等----> 域名代理模式

2. 想在外网通过ssh连接内网的机器，做云服务器到内网服务器端口的映射，----> tcp代理模式

3. 在非内网环境下使用内网dns，或者需要通过udp访问内网机器等----> udp代理模式

4. 在外网使用HTTP代理访问内网站点----> http代理模式

5. 搭建一个内网穿透ss，在外网如同使用内网vpn一样访问内网资源或者设备----> socks5代理模式
## 特点
- 协议支持全面，兼容几乎所有常用协议，例如tcp、udp、http(s)、socks5、p2p、http代理...
- 全平台兼容(linux、windows、macos、群辉等)，支持一键安装为系统服务
- 控制全面，同时支持服务端和客户端控制
- https集成，支持将后端代理和web服务转成https，同时支持多证书
- 操作简单，只需简单的配置即可在web ui上完成其余操作
- 展示信息全面，流量、系统信息、即时带宽、客户端版本等
- 扩展功能强大，该有的都有了（缓存、压缩、加密、流量限制、带宽限制、端口复用等等）
- 域名解析具备自定义header、404页面配置、host修改、站点保护、URL路由、泛解析等功能
- 服务端支持多用户和用户注册功能

**没找到你想要的功能？不要紧，点击[进入文档](https://ehang-io.github.io/nps)查找吧**
**参考 [NPS GitHub](https://github.com/ehang-io/nps) 代码仓库**



#### 使用说明

##### 服务端启动（nps）
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


##### 客户端启动（npc）
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



#### 参与贡献

1.  Fork 本仓库
2.  新建 Feat_xxx 分支
3.  提交代码
4.  新建 Pull Request


#### 分享者信息

1. 分享者邮箱: qiushaocloud@126.com
2. [分享者网站](https://www.qiushaocloud.top)
3. [分享者自己搭建的 gitlab](https://gitlab.qiushaocloud.top/qiushaocloud) 
3. [分享者 gitee](https://gitee.com/qiushaocloud/dashboard/projects) 
3. [分享者 github](https://github.com/qiushaocloud?tab=repositories) 
