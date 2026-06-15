#!/usr/bin/env bash

set -eou pipefail

build_sdl2() {
    cd $root
    ./build.sh x86_64 ports/SDL2 $build_sysroot/usr
    cd $og_work_dir
}


og_work_dir=$(pwd)
INSTALL_ONLY=1 build_sdl2 || INSTALL_ONLY="0" build_sdl2



CFLAGS="-Wno-incompatible-pointer-types"
CC="clang -target x86_64-unknown-none" cmake --fresh -S . -B m_build -G Ninja \
    -DCMAKE_SYSROOT="$build_sysroot" \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX="$output_prefix" \
    -DCMAKE_C_FLAGS="$CFLAGS" \
    --toolchain="$CMAKE_TOOLCHAIN_PATH" \
    -DCMAKE_VERBOSE_MAKEFILE=ON -DCMAKE_EXPORT_COMPILE_COMMANDS=ON \
    -DSDL2_SHARED=NO \
    -DBUILD_SHARED_LIBS=OFF \
    -DSDL2MIXER_DEPS_SHARED=OFF \
	-DSDL2MIXER_MIDI_FLUIDSYNTH=OFF \
	-DSDL2MIXER_WAVPACK=OFF \
	-DSDL2MIXER_OPUS=OFF \
	-DSDL2MIXER_MOD=OFF
cmake --build m_build
cmake --install m_build --prefix "$output_prefix"
