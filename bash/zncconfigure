#!/usr/bin/env bash
set -x

## Debian 7 has too old clang so use this with it
#unset CC
#unset CXX

cd znc
./autogen.sh
mkdir -p build
cd build

## for use with pyenv
#export LD_LIBRARY_PATH=/home/users/mkaysi/.pyenv/versions/3.4.2/lib
#export PKG_CONFIG_PATH=/usr/bin/pkg-config:/home/users/mkaysi/.pyenv/versions/3.4.2/lib/pkgconfig/:/usr/lib/pkgconfig:/usr/lib/x86_64-linux-gnu/pkgconfig/:/usr/share/pkgconfig/

../configure --enable-debug --enable-perl --enable-python --enable-swig --enable-tcl --enable-cyrus

#--prefix=$HOME/.local
#make -j$(nproc)
