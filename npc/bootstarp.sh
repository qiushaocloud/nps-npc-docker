#!/bin/bash

pids=`ps aux | grep "npc -config=" | grep -v grep | awk '{print $2}'`
for pid in $pids
do
        echo killpid:$pid
        kill -9 $pid
done

# mkdir -p /tmp/npsDownloads

# 如果环境变量 RERUN_MAX_NPC_CPU 存在，则进入循环检查 NPC 进程的 CPU 使用率
if [ -n "$RERUN_MAX_NPC_CPU" ]; then
  echo "Starting check npc cpu..."
  echo "RERUN_MAX_NPC_CPU: $RERUN_MAX_NPC_CPU"
  # 启动 NPC 服务
  echo "RUN CMD01: npc -config=/etc/npc/conf/npc.conf"
  nohup npc -config=/etc/npc/conf/npc.conf >/dev/null 2>&1 &

  while true; do
    sleep 120

    curNpcCpu=$(top -b -n3 -p $(ps aux | grep "npc -config=" | grep -v grep | awk '{print $2}') | grep "npc" | tail -1 | awk -F ' ' '{print $9}')
    #echo "curNpcCpu: $curNpcCpu"

    if [ -n "$curNpcCpu" ] && [ $(echo "$curNpcCpu > $RERUN_MAX_NPC_CPU" | bc) -eq 1 ]; then
      echo "npc cpu gt $RERUN_MAX_NPC_CPU, curNpcCpu: $curNpcCpu"
      echo "reset run npc"
      
      pids=$(ps aux | grep "npc -config=" | grep -v grep | awk '{print $2}')
      for pid in $pids
      do
          echo killpid:$pid
          kill -9 $pid
      done

      echo "RUN CMD02: npc -config=/etc/npc/conf/npc.conf"
      nohup npc -config=/etc/npc/conf/npc.conf >/dev/null 2>&1 &
    fi
  done
else
  # 如果环境变量 RERUN_MAX_NPC_CPU 不存在，则直接启动 NPC 服务
  echo "Starting NPC service..."
  echo "RUN CMD03: npc -config=/etc/npc/conf/npc.conf"
  npc -config=/etc/npc/conf/npc.conf
fi
