#!/bin/bash

# 在 master_node 容器中创建目录
docker exec master_node mkdir -p /data/nn
docker exec master_node mkdir /data/dn

# 在 slave_node1 和 slave_node2 容器中创建目录
docker exec slave_node1 mkdir -p /data/dn
docker exec slave_node2 mkdir -p /data/dn

echo "目录创建完成"

