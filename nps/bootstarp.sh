#!/bin/bash

# 如果环境变量 RERUN_MAX_NPS_CPU 存在，则进入循环检查 NPS 进程的 CPU 使用率
if [ -n "$RERUN_MAX_NPS_CPU" ]; then
  echo "Starting check nps cpu..."
  echo "RERUN_MAX_NPS_CPU: $RERUN_MAX_NPS_CPU"
  # 启动 NPS 服务
  nps stop
  nps start

  while true; do
    sleep 120

    # 检查 NPS 服务是否启动成功
    if [ -z "$(ps aux | grep "nps service" | grep -v grep)" ]; then
      echo "nps service not started, reset run nps"
      nps stop
      nps start
      sleep 120
    fi

    # 获取当前 NPS 进程的 CPU 使用率
    curNpsCpu=$(top -b -n3 -p $(ps aux | grep "nps service" | grep -v grep | awk '{print $2}') | grep "nps" | tail -1 | awk -F ' ' '{print $9}')
    #echo "curNpsCpu: $curNpsCpu"

    # 如果当前 NPS 进程的 CPU 使用率大于 RERUN_MAX_NPS_CPU，则重启 NPS 服务
    if [ -n "$curNpsCpu" ] && [ "$(echo "$curNpsCpu > $RERUN_MAX_NPS_CPU" | bc)" -eq 1 ]; then
      echo "nps cpu gt $RERUN_MAX_NPS_CPU, curNpsCpu: $curNpsCpu"
      echo "reset run nps"
      nps stop
      nps start
    fi
  done
else
  # 如果环境变量 RERUN_MAX_NPS_CPU 不存在，则直接启动 NPS 服务
  echo "Starting NPS service..."
  nps stop
  nps # 这里不要用 nps start，而是用 nps 直接运行
fi