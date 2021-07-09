# Using fedora
FROM fedora:latest

# Install all dependencies necessary
RUN sudo dnf install -y \
    cmake \
    git \
    ninja-build \
    gcc-c++-9.3.1 \
    clang-9.0.1 \
    lcov \
    zlib-devel \
    libcurl-devel \
    libuv-devel \
    iputils \
    curl \
    openssl-devel

# If you have a preferred BASH setup, uncomment the following:
# COPY	.profile /root/.profile
# COPY	.bashrc /root/.bashrc

# Set the working directory.
WORKDIR	/tmp