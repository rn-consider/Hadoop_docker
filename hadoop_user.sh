#!/bin/bash

# 在 masternode 容器中执行第一个命令
docker exec -it masternode chown -R hadoop:hadoop /data

# 在 masternode 容器中执行第二个命令
docker exec -it masternode chown -R hadoop:hadoop /export

docker exec -it masternode chown -R hadoop:hadoop /home
# 在 slavenode1 容器中执行第一个命令
docker exec -it slavenode1 chown -R hadoop:hadoop /data

# 在 slavenode1 容器中执行第二个命令
docker exec -it slavenode1 chown -R hadoop:hadoop /export

docker exec -it slavenode1 chown -R hadoop:hadoop /home

# 在 slavenode2 容器中执行第一个命令
docker exec -it slavenode2 chown -R hadoop:hadoop /data

# 在 slavenode2 容器中执行第二个命令
docker exec -it slavenode2 chown -R hadoop:hadoop /export

docker exec -it slavenode2 chown -R hadoop:hadoop /home


echo "在所有容器中的命令已执行完毕"

