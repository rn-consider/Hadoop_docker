#!/bin/bash

# Step 1: 从 masternode 中复制 /etc/profile 到当前目录下
docker cp masternode:/etc/profile ./profile_copy

# Step 2: 在当前目录下的 profile_copy 文件中添加环境变量配置
cat <<EOL >> profile_copy
export HADOOP_HOME=/export/server/hadoop
export PATH=\$PATH:\$HADOOP_HOME/bin:\$HADOOP_HOME/sbin
EOL

# 输出提示
echo "环境变量已添加到 profile_copy 文件"

# Step 3: 复制修改后的 profile_copy 文件到 masternode、slavenode1 和 slavenode2 中
docker cp ./profile_copy masternode:/etc/profile
docker cp ./profile_copy slavenode1:/etc/profile
docker cp ./profile_copy slavenode2:/etc/profile

# Step 4: 在容器中重新加载 profile 文件以使更改生效
docker exec masternode bash -c "source /etc/profile"
docker exec slavenode1 bash -c "source /etc/profile"
docker exec slavenode2 bash -c "source /etc/profile"

# 输出提示
echo "环境变量已添加,请手工在容器终端内输入source /etc/profile使其生效"

# Step 5: 删除临时文件 profile_copy
rm ./profile_copy

