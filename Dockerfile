FROM devkitpro/devkita64:latest
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    git \
    python3 \
    python3-pip \
    ninja-build \
    pkg-config \
    flex \
    bison \
    libx11-dev \
    libxext-dev \
    libxfixes-dev \
    libxcb-glx0-dev \
    libxcb-shm0-dev \
    libx11-xcb-dev \
    libxcb-dri2-0-dev \
    libxcb-dri3-dev \
    libxcb-present-dev \
    libxshmfence-dev \
    libxxf86vm-dev \
    libxrandr-dev \
    libwayland-dev \
    wayland-protocols \
    libwayland-egl-backend-dev \
    libdrm-dev \
    libglvnd-dev \
    libelf-dev \
    zlib1g-dev \
    libzstd-dev \
    clang-15 \
    llvm-15 \
    llvm-15-dev \
    libclang-15-dev \
    lld-15 \
    wget \
    sudo \
    glslang-tools \
    spirv-tools \
    libudev-dev \
    libllvmspirvlib-15-dev \
    libvulkan-dev
# Força o sistema a usar o LLVM/Clang 15 recém instalado
RUN ln -sf /usr/bin/clang-15 /usr/bin/clang && \
    ln -sf /usr/bin/clang++-15 /usr/bin/clang++ && \
    ln -sf /usr/bin/llvm-config-15 /usr/bin/llvm-config && \
    ln -sf /usr/bin/ld.lld-15 /usr/bin/ld.lld
RUN apt-get install -y libclc-15-dev || apt-get install -y libclc-14-dev || apt-get install -y libclc-16-dev || apt-get install -y libclc-dev
RUN pip3 install meson mako --break-system-packages || pip3 install meson mako
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --default-toolchain nightly-2026-09-15
ENV PATH=/root/.cargo/bin:$PATH
RUN rustup component add rust-src --toolchain nightly-2026-09-15
RUN cargo install bindgen-cli cbindgen
