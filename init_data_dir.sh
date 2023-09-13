#!/bin/bash

# 在 masternode 容器中创建目录
docker exec masternode mkdir -p /data/nn
docker exec masternode mkdir /data/dn

# 在 slavenode1 和 slavenode2 容器中创建目录
docker exec slavenode1 mkdir -p /data/dn
docker exec slavenode2 mkdir -p /data/dn

echo "目录创建完成"

