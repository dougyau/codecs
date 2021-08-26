#!/bin/sh
# Disable exit on non 0
set +e
rm -rf build
mkdir -p build
mkdir -p dist

# DEBUG CONFIGURE
#(cd build && emcmake cmake -DCMAKE_BUILD_TYPE=Debug ..) &&

# DOUBLE CONFIGURE
# Workaround for autogenerated `CMakeTmp/CheckSymbolExists.c`
# That contains logic that fails on first run
echo "~~~ CONFIGURE #1 ~~~"
(cd build && emcmake cmake .. || true)
echo "~~~ CONFIGURE #2 ~~~"
(cd build && emcmake cmake ..)
echo "~~~ MAKE ~~~"
(cd build && emmake make VERBOSE=1 -j 16)
echo "~~~ COPY ~~~ "
cp ./build/extern/openjpeg/bin/openjpegjs.js ./dist
cp ./build/extern/openjpeg/bin/openjpegjs.js.mem ./dist
cp ./build/extern/openjpeg/bin/openjpegwasm.js ./dist
cp ./build/extern/openjpeg/bin/openjpegwasm.wasm ./dist

echo "~~~ BUILD:"
(cd build && dir)
echo "~~~ DIST:"
(cd dist && dir)
