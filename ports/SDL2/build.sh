#!/usr/bin/env bash

set -eou pipefail
has_arg() {
    local needle="$1"
    shift

    for arg in "$@"; do
        [[ "$arg" == "$needle" ]] && return 0
    done

    return 1
}

if [[ -z "$ARCH" ]]; then
    echo "Expected ARCH env variable"
    exit 1
fi

NO_INSTALL_ONLY=1
if has_arg --install-only "$@"; then
    NO_INSTALL_ONLY=0
fi

if [[ -z "$INSTALL_ONLY" || "$INSTALL_ONLY" == "0" ]]; then
CFLAGS="-Wno-incompatible-pointer-types"
CC="clang -target x86_64-unknown-none" cmake --fresh -S . -B build -G Ninja \
    -DCMAKE_SYSROOT=$build_sysroot \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX="$output_prefix" \
    -DSDL_LIBC=ON \
    -DCMAKE_C_FLAGS="$CFLAGS" \
    --toolchain="$CMAKE_TOOLCHAIN_PATH" \
    -DCMAKE_VERBOSE_MAKEFILE=ON -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
    cmake --build build
fi
cmake --install build --prefix $output_prefix
echo "Installed raw SDL to $output_prefix"
echo "Building sdl-safaos"

cd sdl-safaos
./build.sh $ARCH || exit 1
cd ..

cp sdl-safaos/out/* $output_prefix/lib/ || exit 1
echo "Success, Installed in $output_prefix"
