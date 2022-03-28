FROM python:3-slim
#FROM ubuntu:latest

# Configure TZDATA, install packages and clean apt cache
RUN apt -y update && \
    apt-get install -yq tzdata && \
    ln -fs /usr/share/zoneinfo/UTC /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata && \
    apt install -y --no-install-recommends python3 python3-pip ssh rsync git wireguard-tools && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

# Install python packages and delete pip cache
RUN python3 -m pip install --upgrade pip && \
    python3 -m pip install install ansible netaddr dnspython && \
    rm -rf `pip3 cache dir`/*

# Add ansible config to container 
RUN mkdir -p /etc/ansible
ADD ansible.cfg /etc/ansible

CMD ["/bin/bash"]