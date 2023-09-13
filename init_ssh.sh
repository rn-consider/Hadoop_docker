#!/bin/bash

# Step 1: 在 master_node 容器中启动 SSH 服务并生成密钥
docker exec -d master_node /usr/sbin/sshd -D &
docker exec master_node ssh-keygen -t rsa -f ~/.ssh/id_rsa -N ""

# Step 2: 在 slave_node1 和 slave_node2 容器中启动 SSH 服务并生成密钥
docker exec -d slave_node1 /usr/sbin/sshd -D &
docker exec -d slave_node2 /usr/sbin/sshd -D &
docker exec slave_node1 ssh-keygen -t rsa -f ~/.ssh/id_rsa -N ""
docker exec slave_node2 ssh-keygen -t rsa -f ~/.ssh/id_rsa -N ""
# Step 2.1: 在三个容器中创建/home/hadoop/.ssh/
docker exec master_node mkdir /home/hadoop

docker exec slave_node1 mkdir /home/hadoop

docker exec slave_node2 mkdir /home/hadoop

docker exec master_node mkdir /home/hadoop/.ssh

docker exec slave_node1 mkdir /home/hadoop/.ssh

docker exec slave_node2 mkdir /home/hadoop/.ssh

# Step 3: 将 master_node 容器中的公钥文件复制到 slave_node1 和 slave_node2 容器
docker cp master_node:/root/.ssh/id_rsa.pub ./master_id_rsa.pub
docker cp master_node:/root/.ssh/id_rsa ./master_id_rsa
# ---------------------------------------------------------------
docker cp ./master_id_rsa.pub master_node:/home/hadoop/.ssh/authorized_keys
docker cp ./master_id_rsa.pub master_node:/home/hadoop/.ssh/authorized_keys
docker cp ./master_id_rsa.pub master_node:/home/hadoop/.ssh/authorized_keys

docker cp ./master_id_rsa.pub master_node:/home/hadoop/.ssh/id_rsa.pub
docker cp ./master_id_rsa master_node:/home/hadoop/.ssh/id_rsa
docker cp ./master_id_rsa.pub slave_node1:/home/hadoop/.ssh/id_rsa.pub
docker cp ./master_id_rsa.pub slave_node2:/home/hadoop/.ssh/id_rsa.pub
docker cp ./master_id_rsa slave_node1:/home/hadoop/.ssh/id_rsa
docker cp ./master_id_rsa slave_node2:/home/hadoop/.ssh/id_rsa

# Step 4: 创建一个临时 SSH 配置文件并保存到当前目录下的 config 文件中
echo "Host *" > ./config
echo "  StrictHostKeyChecking no" >> ./config
echo "  UserKnownHostsFile=/dev/null" >> ./config

# Step 5: 将临时 SSH 配置文件覆盖到三个容器中的 ~/.ssh/config 文件
docker cp ./config master_node:/home/hadoop/.ssh/config
docker cp ./config slave_node1:/home/hadoop/.ssh/config
docker cp ./config slave_node2:/home/hadoop/.ssh/config

# Step 6: 重启 SSH 服务以应用更改
docker exec master_node pkill -f /usr/sbin/sshd
docker exec slave_node1 pkill -f /usr/sbin/sshd
docker exec slave_node2 pkill -f /usr/sbin/sshd

# Step 7: 再次启动 SSH 服务
docker exec -d master_node /usr/sbin/sshd -D &
docker exec -d slave_node1 /usr/sbin/sshd -D &
docker exec -d slave_node2 /usr/sbin/sshd -D &

# Step 8: 删除临时文件
rm ./config
rm ./master_id_rsa
rm ./master_id_rsa.pub
# Step 9: 输出配置已完成
echo "SSH免密配置已经完成"

