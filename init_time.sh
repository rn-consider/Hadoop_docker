#!/bin/bash

# 要执行的命令
COMMANDS=(
    "apt-get update"
    "apt-get install -y tzdata ntpdate"
    "ln -fs /usr/share/zoneinfo/Asia/Shanghai /etc/localtime"
    "dpkg-reconfigure --frontend noninteractive tzdata"
    "ntpdate -u ntp.aliyun.com"
)

# 复制 init_time.sh 到每个容器并执行命令
for container in master_node slave_node1 slave_node2; do
    # 复制 init_time.sh 到容器
    docker cp init_time.sh "$container:/root/"

    # 在容器内执行命令
    for cmd in "${COMMANDS[@]}"; do
        docker exec "$container" bash -c "$cmd"
    done
done

echo "初始化容器时间完成"

