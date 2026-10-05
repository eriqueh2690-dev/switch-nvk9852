#!/bin/bash
set -e
# Corrige o arquivo JSON do Switch para suportar o layout f128 do Rust 2026
sed -i 's/-i128:128-n32:64/-i128:128-f128:128-n32:64/g' /work/aarch64-switch-horizon.json || true
export RUSTFLAGS="-Z location-detail=none -Z fmt-debug=none -C opt-level=3 -C debuginfo=0 -C target-cpu=cortex-a57"
export CC_aarch64_switch_horizon="aarch64-none-elf-gcc"
export CXX_aarch64_switch_horizon="aarch64-none-elf-g++"
export AR_aarch64_switch_horizon="aarch64-none-elf-ar"
export CFLAGS_aarch64_switch_horizon="-O3"
cargo +nightly-2026-09-15 build \
    --target /work/aarch64-switch-horizon.json \
    -Z build-std=core,alloc,compiler_builtins \
    --release \
    --manifest-path /root/.rustup/toolchains/nightly-2026-09-15-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/library/sysroot/Cargo.toml \
    --target-dir /tmp/stdsr
