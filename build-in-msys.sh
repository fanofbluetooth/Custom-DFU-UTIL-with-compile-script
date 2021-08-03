#!/bin/bash

####################################
## Softward versions
####################################
libusb_dir=libusb-1.0.24
libdfuutil_dir=dfu-util-0.10
####################################

set -e

echo "------------------------------------------"
echo "Prepare MSYS2 dependencies..."
echo "------------------------------------------"

# Update the package database and base packages if
# MSYS2 is not very recent.
pacman -Syu

pacman -S --needed \
    tar unzip \
    make libtool autogen autoconf automake \
    mingw-w64-x86_64-gcc mingw-w64-x86_64-make \
    mingw-w64-x86_64-winpthreads-git

if [ ! -d "${libusb_dir}" ]; then
    echo "Extracting ${libusb_dir}.zip..."
    unzip "${libusb_dir}.zip"
fi

if [ ! -d "${libdfuutil_dir}" ]; then
    echo "Extracting ${libdfuutil_dir}.tar.gz..."
    tar xvfz "${libdfuutil_dir}.tar.gz"
fi

echo "------------------------------------------"
echo "Compiling ${libusb_dir}..."
echo "------------------------------------------"
cd "${libusb_dir}"
./bootstrap.sh
./configure --prefix=$PWD/../Build --enable-examples-build --enable-tests-build
make
make install
cd ..

echo "------------------------------------------"
echo "Compiling ${libdfuutil_dir}..."
echo "------------------------------------------"
cd "${libdfuutil_dir}"
# Patch configure.ac that breaks in libusb detection on MSYS2.
# We use own paths to libusb-1.0, we don't need autodetection.
sed -i '/^[^#]/ s/\(^.*PKG_CHECK_MODULES(\[USB\].*$\)/#\ \1/' configure.ac
sed -i '/^[^#]/ s/\(^.*AC_MSG_ERROR.*Required libusb.*$\)/#\ \1/' configure.ac
./autogen.sh
CFLAGS="-I$PWD/../Build/include/libusb-1.0" \
    LIBS="-L $PWD/../Build/lib -lusb-1.0" \
        ./configure --prefix=$PWD/../Build

# Link libusb statically. But if you want to use
# libusb-1.0.dll (dynamic linking), don't add LDFLAGS=-static
make LDFLAGS=-static
make install
cd ..

echo
echo "------------------------------------------"
echo "Congrats! Your projects are compiled in"
echo "Build directory. You do not need to have "
echo "libusb-1.0.dll in Build/bin directory "
echo "since DFU utils have been compiled "
echo "statically with this library."
echo "------------------------------------------"
