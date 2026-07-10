set -eou pipefail
git clone https://github.com/SafaOS/SafaOS --branch GUI
cd SafaOS
./helper.sh install-toolchain --arch x86_64
./helper.sh install-toolchain -arch aarch64
