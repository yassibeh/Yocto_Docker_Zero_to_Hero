FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies required for building Yocto
RUN apt-get update && apt-get install -y \
    sudo git wget curl repo gawk python3 python3-pip \
    python3-pexpect diffstat chrpath socat \
    xz-utils unzip texinfo zstd libegl1-mesa \
    libsdl1.2-dev pylint3 cpio cmake ninja-build \
    libglib2.0-dev screen rsync gcc g++ make locales \
    && apt-get clean

# Configure UTF-8 locale
RUN locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

# Create user with host UID and GID
ARG USERNAME
ARG USER_UID
ARG USER_GID

RUN groupadd --gid $USER_GID $USERNAME && \
    useradd --uid $USER_UID --gid $USER_GID -m $USERNAME && \
    echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER $USERNAME
WORKDIR /home/$USERNAME
