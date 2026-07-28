set -eou pipefail
git clone https://github.com/SafaOS/SafaOS
cd SafaOS
./helper.sh init --arch x86_64
./helper.sh init --arch aarch64
