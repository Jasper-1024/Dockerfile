#!/bin/sh
COMMAND=$OVERTURE_HOME/overture

if [ "$1" = "--help" ]; then
    set -- $COMMAND -h
else 
    crond # 启动定时任务
    cd $OVERTURE_HOME
    set -- $COMMAND $@
 #   while true; do
 #       sleep 5
 #   done
 #   cd $OVERTURE_HOME
 #   set -- $COMMAND $@
 #   mkfifo /tmp/overture # 创建命名管道
 #   while true; do #启动一个循环
 #       cat /tmp/overture > restart #检查命名管道重启信号
 #       pkill overture
 #       set -- $COMMAND $@
 #       sleep 5
 #   done
fi
``
exec "$@"