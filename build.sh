#!/bin/bash
#

# Build Mackay kernel for p4wifi

# Set basic parameters
DATE_START=$(date +"%s")

MACKAY_VER="Mackay_1.1"

export ARCH=arm
export LOCALVERSION="-"`echo $MACKAY_VER`
export CROSS_COMPILE=/home/kasper/android/cm102/prebuilt/linux-x86/toolchain/arm-eabi-4.4.3/bin/arm-eabi-

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
make mackay_p4wifi_defconfig
make -j4

# Move modules and kernel to output folder
# rm `echo $MODULES_DIR"/*"`

find $SOURCE_DIR -name '*.ko' -exec cp -v {} $MODULES_DIR \;
chmod 644 `echo $MODULES_DIR"/*"`

cp arch/arm/boot/zImage $KERNEL_DIR

# Create flashable zip
cd $OUTPUT_DIR
zip -r `echo $MACKAY_VER`.zip *
cp `echo $MACKAY_VER`.zip /home/kasper/AndroidFlash/p4wifi/stock_kernel

DATE_END=$(date +"%s")
echo
DIFF=$(($DATE_END - $DATE_START))
echo "Build completed in $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) seconds."
