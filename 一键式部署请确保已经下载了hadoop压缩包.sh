#!/bin/bash
if [ -f "hadoop.tar.gz" ]; then
  echo "请确保docker-compose -d 命令已经运行!"
  ./init_ssh.sh
  ./init_time.sh
  ./file_config.sh
  ./init_data_dir.sh
  ./distribution_hadoop.sh
  ./path_config.sh
  ./hadoop_user.sh

else 
  echo "确认你已经做好了hadoop压缩包的下载和重命名!项目结构应与项目结构图一致！！"
fi

