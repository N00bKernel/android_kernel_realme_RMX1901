#!/bin/bash
rm -rf /out
make kernelversion
date
export ARCH=arm64 && export SUBARCH=arm64 modded_defconfig
export CROSS_COMPILE=~/TOOLCHAIN/aarch64-linux-gnu/bin/aarch64-linux-gnu-
#export CROSS_COMPILE_ARM32=~/TOOLCHAIN/arm-linux-gnueabi/bin/arm-linux-gnueabi-
export USE_CCACHE=1
export USE_PREBUILT_CACHE=1
export PREBUILT_CACHE_DIR=~/.ccache
export CCACHE_DIR=~/.ccache
ccache -M 50G
mkdir -p out
make O=out clean
make O=out modded_defconfig
make -j$(nproc --all) O=out 
mv out/arch/arm64/boot/Image.gz ~/TOOLCHAIN/anykernel/Image.gz
rm -rf out
cd ~/TOOLCHAIN/anykernel
zip -r n00b_kernel_$(date +"%Y-%m-%d").zip *
rm -rf Image.gz
mkdir ~/Desktop/n00b/
mv n00b_kernel_$(date +"%Y-%m-%d").zip ~/Desktop/n00b/
cd ~/Desktop/n00b/
ls
date
