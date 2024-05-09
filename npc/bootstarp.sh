#!/bin/bash

CUR_DIR=$(dirname "$0")
echo "CUR_DIR: $CUR_DIR"

# 如果环境变量 MAX_NPS_CPU 存在，则进入循环检查 NPS 进程的 CPU 使用率
if [ -n "$MAX_NPS_CPU" ]; then
  echo "Starting check nps cpu..."
  echo "MAX_NPS_CPU: $MAX_NPS_CPU"
  # 启动 NPS 服务
  nps stop
  nps start

  while true; do
    sleep 1

    curNpsCpu=$(top -b -n3 -p $(ps aux | grep "nps service" | grep -v grep | awk '{print $2}') | grep "nps" | tail -1 | awk -F ' ' '{print $9}')
    #echo "curNpsCpu: $curNpsCpu"

    if [ -n "$curNpsCpu" ] && [ "$(echo "$curNpsCpu > $MAX_NPS_CPU" | bc)" -eq 1 ]; then
      echo "nps cpu gt $MAX_NPS_CPU, curNpsCpu: $curNpsCpu"
      echo "reset run nps"
      nps stop
      nps start
    fi
  done
else
  # 如果环境变量 MAX_NPS_CPU 不存在，则直接启动 NPS 服务
  echo "Starting NPS service..."
  nps stop
  nps start
fi
