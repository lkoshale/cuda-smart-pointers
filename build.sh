#!/bin/bash

rm -rf build

mkdir build
cd build

cmake ..
make

echo "please run: ./build/src/test/testapp"
