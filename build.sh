#!/bin/bash
#

# Build Infamous kernel for p4wifi

# Set basic parameters
DATE_START=$(date +"%s")

INFAMOUS_VER="Infamous_JB43_1.0"

export ARCH=arm
export LOCALVERSION="-"`echo $INFAMOUS_VER`
# export CROSS_COMPILE=/home/kasper/android/cm102/prebuilt/linux-x86/toolchain/arm-eabi-4.4.3/bin/arm-eabi-
export CROSS_COMPILE=/home/kasper/android/cm102/prebuilts/gcc/linux-x86/arm/arm-eabi-4.6/bin/arm-eabi-


BASE_DIR=/home/kasper/android/cm102/kernel/samsung
SOURCE_DIR=`echo $BASE_DIR`/p4
OUTPUT_DIR=`echo $BASE_DIR`/output/galaxytab
KERNEL_DIR=`echo $OUTPUT_DIR`/kernel
MODULES_DIR=`echo $OUTPUT_DIR`/modules

# Clean
rm $KERNEL_DIR/zImage
rm $OUTPUT_DIR/*.zip

# Build
cd $SOURCE_DIR
make infamous_p4wifi_defconfig
make -j4

# Move modules and kernel to output folder
# rm `echo $MODULES_DIR"/*"`

find $SOURCE_DIR -name '*.ko' -exec cp -v {} $MODULES_DIR \;
chmod 644 `echo $MODULES_DIR"/*"`

cp arch/arm/boot/zImage $KERNEL_DIR

# Create flashable zip
cd $OUTPUT_DIR
zip -r `echo $INFAMOUS_VER`.zip *

DATE_END=$(date +"%s")
echo
DIFF=$(($DATE_END - $DATE_START))
echo "Build completed in $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) seconds."
