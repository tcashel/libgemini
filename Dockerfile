# Using fedora
FROM fedora:latest

# Install all dependencies necessary
RUN sudo dnf install -y \
    cmake \
    git \
    gdb \
    ninja-build \
    gcc-c++ \
    clang \
    lcov \
    zlib-devel \
    libcurl-devel \
    libuv-devel \
    iputils \
    curl \
    openssl-devel \
    ccache

# If you have a preferred BASH setup, uncomment the following:
# COPY	.profile /root/.profile
# COPY	.bashrc /root/.bashrc

# Set the working directory.
WORKDIR	/libgemini