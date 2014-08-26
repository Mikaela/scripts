#!/usr/bin/env bash
cd znc
./autogen.sh
mkdir -p build
cd build
# PYENV (two lines)
export LD_LIBRARY_PATH=/home/users/mkaysi/.pyenv/versions/3.4.1/lib
export PKG_CONFIG_PATH=/home/users/mkaysi/.pyenv/versions/3.4.1/lib/pkgconfig/
../configure --enable-debug --enable-perl --enable-python --enable-swig --enable-tcl --disable-cyrus --prefix=$HOME/.local
make -j$(nproc)
