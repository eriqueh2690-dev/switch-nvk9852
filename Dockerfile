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
    clang \
    llvm \
    lld \
    lldb \
    wget \
    sudo
# As versões mais novas de Python no Debian/Ubuntu do devkitpro exigem flag extra no pip
RUN pip3 install meson mako --break-system-packages || pip3 install meson mako
# O devkitpro/devkita64 JÁ VEM com switch-dev. Só pedimos o mesa e libdrm.
# Como é uma requisição pequena e em imagem oficial, eles não bloqueiam o IP.
RUN dkp-pacman -Sy --noconfirm switch-mesa switch-libdrm
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --default-toolchain nightly-2026-09-15
ENV PATH=/root/.cargo/bin:$PATH
RUN rustup component add rust-src --toolchain nightly-2026-09-15
RUN cargo install bindgen-cli cbindgen
