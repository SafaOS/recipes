#!/usr/bin/env bash

if [[ -z "$1" ]]; then
    echo "Usage: [ARCH] [PORT NAME] [DEST DIR]"
    exit 1
fi

if [[ -z "$2" ]]; then
    echo "Usage: [ARCH] [PORT NAME] [DEST DIR]"
    exit 1
fi

if [[ -z "$3" ]]; then
    echo "Usage: [ARCH] [PORT NAME] [DEST DIR]"
    exit 1
fi

set -euo pipefail
export ARCH=$1
PORT_NAME=$2
DEST_DIR=$3
OG_WORK_DIR=$(pwd)

cd $PORT_NAME
. ./info
cd $OG_WORK_DIR

git submodule init
git submodule update

export build_sysroot="$(pwd)/build"
export output_prefix="$(pwd)/$DEST_DIR"

export CMAKE_TOOLCHAIN_PATH="$(pwd)/safa-build/Toolchain.txt"

cd safa-build
./make-sysroot $ARCH $build_sysroot
cd ..


cd $PORT_NAME

if git clone --filter=blob:none --branch $BRANCH $REPO repo ; then
    cd repo
    git checkout "$COMMIT"
    git checkout -b port
    git apply ../*.patch
else
    cd repo
    echo "Repo already cloned, please delete it to reclone"
fi


../build.sh
