
FROM pytorch/pytorch:1.10.0-cuda11.3-cudnn8-devel

ARG https_proxy
ARG http_proxy

ARG HOST_NCCL_PATH=/home/tzj/libs/nccl-tests

ARG FRAMEWORK=pytorch
ARG NCCL_BASE_PATH=/usr/local
ARG NCCL_PATH=$NCCL_BASE_PATH/nccl-tests
ARG COMSCRIBE_PATH=$NCCL_BASE_PATH/ComScribe
ARG MPI_PATH=$NCCL_BASE_PATH
ARG NCCL_GIT_LINK=https://github.com/NVIDIA/nccl-tests
ARG NCCL_BRANCH=master

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-key del 7fa2af80
RUN apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/3bf863cc.pub
RUN apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1804/x86_64/7fa2af80.pub
RUN apt-get update
RUN apt-get install -y --allow-downgrades --allow-change-held-packages --no-install-recommends \
        build-essential \
        numactl \
        tzdata \
        ca-certificates \
        git \
        curl \
        wget \
        vim \
        net-tools \
        cmake \
        lsb-release \
        libnuma-dev \
        ibverbs-providers \
        librdmacm-dev \
        ibverbs-utils \
        rdmacm-utils \
        libibverbs-dev \
        python3 \
        python3-dev \
        python3-pip \
        python3-setuptools

# NVIDIA Nsight Systems 2020.2.1
RUN apt-get update -y && \
     DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
         apt-transport-https \
         ca-certificates \
         gnupg \
         wget && \
     rm -rf /var/lib/apt/lists/*
RUN wget -qO - https://developer.download.nvidia.com/devtools/repos/ubuntu1804/amd64/nvidia.pub | apt-key add - && \
     echo "deb https://developer.download.nvidia.com/devtools/repos/ubuntu1804/amd64/ /" >> /etc/apt/sources.list.d/nsight.list && \
     apt-get update -y && \
     DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends nsight-systems-2023.1.1 &&\
     rm -rf /var/lib/apt/lists/*

# install framework
# note: for tf <= 1.14, you need gcc-4.9
RUN pip3 install -U torchvision==0.11.1;

# Install Comscribe
RUN cd $NCCL_BASE_PATH && \
    git clone https://github.com/ParCoreLab/ComScribe.git &&\
    cd $COMSCRIBE_PATH &&\
    ./install.sh

RUN wget https://download.open-mpi.org/release/open-mpi/v4.1/openmpi-4.1.5.tar.gz &&\
    tar -xvf openmpi-4.1.5.tar.gz &&\
    cd openmpi-4.1.5 &&\
    ./configure --prefix=$MPI_PATH --enable-mpi-cxx --enable-mpi-thread-multiple --enable-shared --enable-orterun-prefix-by-default --disable-fortran &&\
    make -j 32 &&\
    make install

ADD ./nccl-tests ${NCCL_PATH}

# Install nccl-test
RUN cd $NCCL_PATH &&\
    make MPI=1 MPI_HOME=$NCCL_BASE_PATH/openmpi-4.1.5 CUDA_HOME=/usr/local/cuda-11.3/ NCCL_HOME=/usr/lib/x86_64-linux-gnu/


