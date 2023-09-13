#!/bin/bash

# 定义容器名称和目标目录
container_name="master_node"
target_directory="/export/server/hadoop/etc/hadoop"

# 检查容器是否正在运行
if docker ps -q -f "name=$container_name" 1>/dev/null; then
    # 容器正在运行，将文件拷贝到容器
    docker cp ./fileconfig/. "$container_name:$target_directory"
    echo "文件已成功拷贝到容器 $container_name 的目录 $target_directory 中"
else
    echo "错误：容器 $container_name 未在运行中"
fi

