#!/bin/bash

# Step 1: 从 masternode 容器中复制 Hadoop 配置文件到当前目录
docker cp masternode:/export/server/hadoop/etc/hadoop/workers .
docker cp masternode:/export/server/hadoop/etc/hadoop/hadoop-env.sh .
docker cp masternode:/export/server/hadoop/etc/hadoop/core-site.xml .
docker cp masternode:/export/server/hadoop/etc/hadoop/hdfs-site.xml .

# Step 2: 复制并覆盖剩下两个容器的 Hadoop 配置文件
docker cp workers slavenode1:/export/server/hadoop/etc/hadoop/
docker cp hadoop-env.sh slavenode1:/export/server/hadoop/etc/hadoop/
docker cp core-site.xml slavenode1:/export/server/hadoop/etc/hadoop/
docker cp hdfs-site.xml slavenode1:/export/server/hadoop/etc/hadoop/

docker cp workers slavenode2:/export/server/hadoop/etc/hadoop/
docker cp hadoop-env.sh slavenode2:/export/server/hadoop/etc/hadoop/
docker cp core-site.xml slavenode2:/export/server/hadoop/etc/hadoop/
docker cp hdfs-site.xml slavenode2:/export/server/hadoop/etc/hadoop/

# Step 3: 删除当前目录下由步骤 1 复制出来的文件
rm -f workers hadoop-env.sh core-site.xml hdfs-site.xml

echo "Hadoop 配置文件已复制并覆盖完成"

