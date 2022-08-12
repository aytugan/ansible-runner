FROM ubuntu:20.04
#FROM python:3-slim

# Configure TZDATA, install packages and clean apt cache
RUN apt -y update && \
    apt-get install -yq tzdata && \
    ln -fs /usr/share/zoneinfo/UTC /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata && \
    apt install -y --no-install-recommends python3 python3-pip ssh rsync git wireguard-tools unzip && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

# Install python packages and delete pip cache
RUN python3 -m pip install --upgrade pip && \
    python3 -m pip install install ansible netaddr dnspython ansible-lint && \
    rm -rf `pip3 cache dir`/*

# Add ansible config to container 
RUN mkdir -p /etc/ansible
ADD ansible.cfg /etc/ansible

# Install aliyun cmdline tool
ADD https://github.com/aliyun/aliyun-cli/releases/download/v3.0.111/aliyun-cli-linux-3.0.111-amd64.tgz /tmp/aliyun-cli-linux-amd64.tgz
RUN cd /usr/local/bin/ && tar -xvzf /tmp/aliyun-cli-linux-amd64.tgz && \
    rm /tmp/aliyun-cli-linux-amd64.tgz

CMD ["/bin/bash"]