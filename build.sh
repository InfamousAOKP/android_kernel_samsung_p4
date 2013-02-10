#!/bin/bash
#

# Build Mackay kernel for p4wifi

DATE_START=$(date +"%s")

MACKAY_VER="Mackay_1.0"

export ARCH=arm
export name
export LOCALVERSION="-"`echo $MACKAY_VER`
export CROSS_COMPILE=/home/kasper/android/cm101/prebuilt/linux-x86/toolchain/arm-eabi-4.4.3/bin/arm-eabi-

KERNEL_DIR=`pwd`
OUTPUT_DIR=../output
MODULES_DIR=`echo $OUTPUT_DIR`/modules

make mackay_p4wifi_defconfig

make modules

rm `echo $MODULES_DIR"/*"`
find $KERNEL_DIR -name '*.ko' -exec cp -v {} $MODULES_DIR \;
chmod 644 `echo $MODULES_DIR"/*"`

make zImage
mv arch/arm/boot/zImage $OUTPUT_DIR/kernel

cd $OUTPUT_DIR
zip -r `echo $MACKAY_VER`.zip *

DATE_END=$(date +"%s")
echo
DIFF=$(($DATE_END - $DATE_START))
echo "Build completed in $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) seconds."
