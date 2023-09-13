#!/bin/bash

# 停止和删除Docker Compose服务
docker-compose down

# 删除Docker镜像
docker rmi root-slave_node2
docker rmi root-slave_node1
docker rmi root-master_node

# 输出消息以确认操作完成
echo "Cleanup completed."

