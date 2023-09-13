#!/bin/bash

# 在 master_node 容器中执行第一个命令
docker exec -it master_node chown -R hadoop:hadoop /data

# 在 master_node 容器中执行第二个命令
docker exec -it master_node chown -R hadoop:hadoop /export

docker exec -it master_node chown -R hadoop:hadoop /home
# 在 slave_node1 容器中执行第一个命令
docker exec -it slave_node1 chown -R hadoop:hadoop /data

# 在 slave_node1 容器中执行第二个命令
docker exec -it slave_node1 chown -R hadoop:hadoop /export

docker exec -it slave_node1 chown -R hadoop:hadoop /home

# 在 slave_node2 容器中执行第一个命令
docker exec -it slave_node2 chown -R hadoop:hadoop /data

# 在 slave_node2 容器中执行第二个命令
docker exec -it slave_node2 chown -R hadoop:hadoop /export

docker exec -it slave_node2 chown -R hadoop:hadoop /home


echo "在所有容器中的命令已执行完毕"

