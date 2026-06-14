#!/usr/bin/env bash

if [[ -z "$1" ]]; then
    echo "Usage: [ARCH]"
    exit 1
fi
ARCH=$1

set -eou pipefail

for port in ports/*/; do
    echo "========== Building $port ============="
    ./build.sh $ARCH "$port" "out/$port"
    echo "========= Done Building $port ==========="
done
