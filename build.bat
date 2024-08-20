#!/bin/bash

# note use -E flag to retain ANDROID_NDK_HOME env var

API_LEVEL=31

ARCHITECTURES=("arm64-v8a" "armeabi-v7a" "x86" "x86_64")

AR_DIR=$ANDROID_NDK_HOME/toolchains/llvm/prebuilt/linux-x86_64/bin/llvm-ar

rm -rf dist

for ARCH in "${ARCHITECTURES[@]}"; do
    case $ARCH in
        "arm64-v8a")
            TOOLCHAIN=$ANDROID_NDK_HOME/toolchains/llvm/prebuilt/linux-x86_64/bin/aarch64-linux-android$API_LEVEL-clang
            ;;
        "armeabi-v7a")
            TOOLCHAIN=$ANDROID_NDK_HOME/toolchains/llvm/prebuilt/linux-x86_64/bin/armv7a-linux-androideabi$API_LEVEL-clang
            ;;
        "x86")
            TOOLCHAIN=$ANDROID_NDK_HOME/toolchains/llvm/prebuilt/linux-x86_64/bin/i686-linux-android$API_LEVEL-clang
            ;;
        "x86_64")
            TOOLCHAIN=$ANDROID_NDK_HOME/toolchains/llvm/prebuilt/linux-x86_64/bin/x86_64-linux-android$API_LEVEL-clang
            ;;
    esac

    BUILD_DIR=dist/$ARCH
    mkdir -p $BUILD_DIR
    make shared CC=$TOOLCHAIN AR=$AR_DIR prefix=$BUILD_DIR
done
