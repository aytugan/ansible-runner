FROM python:3-slim
#FROM ubuntu:latest

RUN apt update -y

# Configure TZDATA
RUN apt-get install -yq tzdata && \
    ln -fs /usr/share/zoneinfo/UTC /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata

# Install packages
RUN apt install -y --no-install-recommends python3 python3-pip ssh rsync git wireguard-tools

# Install python packages
RUN python3 -m pip install --upgrade pip
RUN python3 -m pip install install ansible netaddr

# Do not check known_hosts in ansible 
RUN export ANSIBLE_HOST_KEY_CHECKING=False

CMD ["/bin/bash"]