#!/bin/bash

# 停止和删除Docker Compose服务
docker-compose down

# 删除Docker镜像
docker rmi root-slavenode2
docker rmi root-slavenode1
docker rmi root-masternode

# 输出消息以确认操作完成
echo "Cleanup completed."

