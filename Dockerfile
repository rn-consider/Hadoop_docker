FROM ubuntu:20.04

COPY hadoop.tar.gz /export/server/
RUN apt-get update && apt-get install -y ca-certificates && \
    echo "deb https://mirrors.aliyun.com/ubuntu/ focal main restricted universe multiverse" > /etc/apt/sources.list && \
    echo "deb-src https://mirrors.aliyun.com/ubuntu/ focal main restricted universe multiverse" >> /etc/apt/sources.list && \
    echo "deb https://mirrors.aliyun.com/ubuntu/ focal-security main restricted universe multiverse" >> /etc/apt/sources.list && \
    echo "deb-src https://mirrors.aliyun.com/ubuntu/ focal-security main restricted universe multiverse" >> /etc/apt/sources.list && \
    echo "deb https://mirrors.aliyun.com/ubuntu/ focal-updates main restricted universe multiverse" >> /etc/apt/sources.list && \
    echo "deb-src https://mirrors.aliyun.com/ubuntu/ focal-updates main restricted universe multiverse" >> /etc/apt/sources.list && \
    echo "deb https://mirrors.aliyun.com/ubuntu/ focal-backports main restricted universe multiverse" >> /etc/apt/sources.list && \
    echo "deb-src https://mirrors.aliyun.com/ubuntu/ focal-backports main restricted universe multiverse" >> /etc/apt/sources.list && \
    apt update && \
    apt-get install lsof && \
    apt-get install openssh-server -y && \
    mkdir -p /var/run/sshd && \
    chmod 755 /var/run/sshd && \
    apt-get install -y openjdk-8-jdk && \
    apt-get install -y tar && \
    mkdir /export || mkdir /export/server || \
    tar -zxvf /export/server/hadoop.tar.gz -C /export/server && \
    rm -f /export/server/hadoop.tar.gz && mv /export/server/hadoop-3.3.6 /export/server/hadoop && \
    useradd hadoop &&  echo "hadoop:123456" | chpasswd
