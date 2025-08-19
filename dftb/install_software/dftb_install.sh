#!/bin/bash

cd 
rm -rf dftbplus

if grep -Fxq 'export PATH="$HOME/opt/dftb+/bin:$PATH' "$HOME/.bashrc"; then
    sed -i '\|export PATH="$HOME/opt/dftb+/bin:$PATH|s|^|# |' "$HOME/.bashrc"
fi


git clone https://github.com/dftbplus/dftbplus.git
cd dftbplus
./utils/get_opt_externals
sed -i '/option(WITH_TBLITE "Whether xTB support should be included via tblite."/ s/FALSE/TRUE/' config.cmake
sed -i '/option(WITH_PLUMED "Whether metadynamics via the PLUMED2 library should be allowed for"/ s/FALSE/TRUE/' config.cmake
sed -i '/set(TEST_OMP_THREADS "1" CACHE STRING "Nr. of OpenMP-threads used for testing")/ s/"1"/"16"/' config.cmake
FC=gfortran CC=gcc cmake -DCMAKE_INSTALL_PREFIX=$HOME/opt/dftb+ -DBLAS_LIBRARY=$CONDA_PREFIX/lib/libblas.so -DPLUMED_LIBRARY="$HOME/opt/lib/libplumed.so;$HOME/opt/lib/libplumedKernel.so" -B _build .
cmake --build _build -- -j 4 VERBOSE=1
cmake --install _build
echo 'export PATH="$HOME/opt/dftb+/bin:$PATH"' >> $HOME/.bashrc