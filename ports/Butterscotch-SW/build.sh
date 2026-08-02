set -eou pipefail

build_sdl2() {
    cd $root
    ./build.sh x86_64 ports/SDL2 $build_sysroot/usr
    cd $og_work_dir
}


og_work_dir=$(pwd)
INSTALL_ONLY=1 build_sdl2 || INSTALL_ONLY="0" build_sdl2


rm sysroot || true
ln -s $build_sysroot ./sysroot
make -f Makefile.safaOS distclean
make -f Makefile.safaOS -j 4
cp build/butterscotch $output_prefix
