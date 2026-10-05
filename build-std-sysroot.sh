#!/bin/bash
set -e
# Força bruta: Injeta no JSON EXATAMENTE o layout padrão do LLVM do Rust novo, não importa o que estava lá antes.
sed -i 's/"data-layout": .*/"data-layout": "e-m:e-p270:32:32-p271:32:32-p272:64:64-i8:8:32-i16:16:32-i64:64-i128:128-n32:64-S128-Fn32",/g' /work/aarch64-switch-horizon.json || true
export RUSTFLAGS="-Z location-detail=none -Z fmt-debug=none -C opt-level=3 -C debuginfo=0 -C target-cpu=cortex-a57"
export CC_aarch64_switch_horizon="aarch64-none-elf-gcc"
export CXX_aarch64_switch_horizon="aarch64-none-elf-g++"
export AR_aarch64_switch_horizon="aarch64-none-elf-ar"
export CFLAGS_aarch64_switch_horizon="-O3"
cargo +nightly-2026-09-15 build \
  -Z json-target-spec \
  --target /work/aarch64-switch-horizon.json \
  -Z build-std=core,alloc,compiler_builtins,panic_abort \
  --release \
  --manifest-path /root/.rustup/toolchains/nightly-2026-09-15-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/library/sysroot/Cargo.toml \
  --target-dir /tmp/stdsr
