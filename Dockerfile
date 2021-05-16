FROM ubuntu:20.04

ENV TZ=UTC
ARG DEBIAN_FRONTEND=noninteractive
ARG CC=/usr/bin/gcc-10
ARG CXX=/usr/bin/g++-10


RUN apt update && \
    apt -y upgrade && \
    apt -y install git wget apt-transport-https ca-certificates curl gnupg lsb-release cmake build-essential libcurl4-openssl-dev software-properties-common && \
    add-apt-repository ppa:ubuntu-toolchain-r/test && \
    wget -O /etc/apt/preferences.d/cuda-repository-pin-600 https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-ubuntu2004.pin && \
    wget -O /tmp/nvidia.pub https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/7fa2af80.pub && \
    apt-key add /tmp/nvidia.pub && \
    add-apt-repository "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/ /" && \
    apt update && \
    apt -y install cuda gcc-10 && \
    apt autoclean && \
    apt -y autoremove

RUN git clone https://github.com/jimmystewpot/ethminer.git /usr/src/ethminer && \
    cd /usr/src/ethminer && \
    git submodule update --init --recursive && \
    mkdir build && \
    cd build && \
    cmake -DETHASHCL=OFF -DETHASHCUDA=ON -DAPICORE=ON -DBINKERN=ON -DETHASHCPU=ON -DHUNTER_JOBS_NUMBER=4 .. && \
    cmake --build . && \
    make install

ENTRYPOINT [ "/usr/local/bin/ethminer", "-U", "-P", "stratumss://${WALLET_ADDRESS}.${WORKER_NAME}@eu1.ethermine.org:5555", "--api-bind", "127.0.0.1:8080", "--api-password", "EthMiner", "--noeval", "-v", "2", "-R"]
