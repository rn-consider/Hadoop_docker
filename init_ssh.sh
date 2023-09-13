#!/bin/bash

# Step 1: 在 masternode 容器中启动 SSH 服务并生成密钥
docker exec -d masternode /usr/sbin/sshd -D &
docker exec masternode ssh-keygen -t rsa -f ~/.ssh/id_rsa -N ""

# Step 2: 在 slavenode1 和 slavenode2 容器中启动 SSH 服务并生成密钥
docker exec -d slavenode1 /usr/sbin/sshd -D &
docker exec -d slavenode2 /usr/sbin/sshd -D &
docker exec slavenode1 ssh-keygen -t rsa -f ~/.ssh/id_rsa -N ""
docker exec slavenode2 ssh-keygen -t rsa -f ~/.ssh/id_rsa -N ""
# Step 2.1: 在三个容器中创建/home/hadoop/.ssh/
docker exec masternode mkdir /home/hadoop

docker exec slavenode1 mkdir /home/hadoop

docker exec slavenode2 mkdir /home/hadoop

docker exec masternode mkdir /home/hadoop/.ssh

docker exec slavenode1 mkdir /home/hadoop/.ssh

docker exec slavenode2 mkdir /home/hadoop/.ssh

# Step 3: 将 masternode 容器中的公钥文件复制到 slavenode1 和 slavenode2 容器
docker cp masternode:/root/.ssh/id_rsa.pub ./master_id_rsa.pub
docker cp masternode:/root/.ssh/id_rsa ./master_id_rsa
# ---------------------------------------------------------------
# 1.把./master_id_rsa.pub复制到masternode:/home/hadoop/.ssh/authorized_keys
docker cp ./master_id_rsa.pub masternode:/home/hadoop/.ssh/authorized_keys
docker cp ./master_id_rsa.pub slavenode1:/home/hadoop/.ssh/authorized_keys
docker cp ./master_id_rsa.pub slavenode2:/home/hadoop/.ssh/authorized_keys

docker cp ./master_id_rsa.pub masternode:/home/hadoop/.ssh/id_rsa.pub
docker cp ./master_id_rsa.pub slavenode1:/home/hadoop/.ssh/id_rsa.pub
docker cp ./master_id_rsa.pub slavenode2:/home/hadoop/.ssh/id_rsa.pub
docker cp ./master_id_rsa masternode:/home/hadoop/.ssh/id_rsa
docker cp ./master_id_rsa slavenode1:/home/hadoop/.ssh/id_rsa
docker cp ./master_id_rsa slavenode2:/home/hadoop/.ssh/id_rsa

# Step 4: 创建一个临时 SSH 配置文件并保存到当前目录下的 config 文件中
echo "Host *" > ./config
echo "  StrictHostKeyChecking no" >> ./config
echo "  UserKnownHostsFile=/dev/null" >> ./config

# Step 5: 将临时 SSH 配置文件覆盖到三个容器中的 ~/.ssh/config 文件
docker cp ./config masternode:/home/hadoop/.ssh/config
docker cp ./config slavenode1:/home/hadoop/.ssh/config
docker cp ./config slavenode2:/home/hadoop/.ssh/config

# Step 6: 重启 SSH 服务以应用更改
docker exec masternode pkill -f /usr/sbin/sshd
docker exec slavenode1 pkill -f /usr/sbin/sshd
docker exec slavenode2 pkill -f /usr/sbin/sshd

# Step 7: 再次启动 SSH 服务
docker exec -d masternode /usr/sbin/sshd -D &
docker exec -d slavenode1 /usr/sbin/sshd -D &
docker exec -d slavenode2 /usr/sbin/sshd -D &

# Step 8: 删除临时文件
rm ./config
rm ./master_id_rsa
rm ./master_id_rsa.pub
# Step 9: 输出配置已完成
echo "SSH免密配置已经完成"

