#! /bin/bash
set -e

extra_cmake_args=(
    -GNinja
    -DWERROR=OFF
)

mkdir build && cd build

cmake ${CMAKE_ARGS} "${extra_cmake_args[@]}" \
    $SRC_DIR

ninja
ninja install

# Skip tests during cross-compilation
if [[ "${CONDA_BUILD_CROSS_COMPILE:-}" != "1" ]]; then
    ninja test
fi
