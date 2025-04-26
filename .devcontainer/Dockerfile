FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies required for building Yocto
RUN apt-get update && apt-get install -y \
    sudo git wget curl gawk python3 python3-pip \
    python3-pexpect diffstat chrpath socat \
    xz-utils unzip texinfo zstd libegl1-mesa \
    libsdl1.2-dev pylint3 cpio cmake ninja-build \
    libglib2.0-dev screen rsync gcc g++ make locales \
    && apt-get clean

# Install repo manually (not available via apt)
RUN curl https://storage.googleapis.com/git-repo-downloads/repo > /usr/local/bin/repo && \
    chmod a+x /usr/local/bin/repo


# Configure UTF-8 locale
RUN locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

# Create user with host UID and GID
ARG USERNAME
ARG USER_UID
ARG USER_GID

RUN groupadd --gid $USER_GID $USERNAME && \
    useradd --uid $USER_UID --gid $USER_GID -m -s /bin/bash $USERNAME && \
    echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Set hostname-based prompt format in .bashrc
RUN echo 'export PS1="\\u@\\h:\\w\\$ "' >> /etc/bash.bashrc

USER $USERNAME
WORKDIR /home/$USERNAME
