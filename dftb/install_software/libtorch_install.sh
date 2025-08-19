#!/bin/bash

cd 
rm -rf libtorch

if grep -Fxq ". /home/mjg120/libtorch/sourceme.sh" "$HOME/.bashrc"; then
    sed -i "\|. /home/mjg120/libtorch/sourceme.sh|d" "$HOME/.bashrc"
fi

wget https://download.pytorch.org/libtorch/cpu/libtorch-cxx11-abi-shared-with-deps-1.13.1%2Bcpu.zip
unzip libtorch-cxx11-abi-shared-with-deps-1.13.1+cpu.zip ;
rm libtorch-cxx11-abi-shared-with-deps-1.13.1+cpu.zip
LIBTORCH=${PWD}/libtorch

echo "export CPATH=${LIBTORCH}/include/torch/csrc/api/include/:${LIBTORCH}/include/:${LIBTORCH}/include/torch:$CPATH" >> ${LIBTORCH}/sourceme.sh
echo "export INCLUDE=${LIBTORCH}/include/torch/csrc/api/include/:${LIBTORCH}/include/:${LIBTORCH}/include/torch:$INCLUDE" >> ${LIBTORCH}/sourceme.sh
echo "export LIBRARY_PATH=${LIBTORCH}/lib:$LIBRARY_PATH" >> ${LIBTORCH}/sourceme.sh
echo "export LD_LIBRARY_PATH=${LIBTORCH}/lib:$LD_LIBRARY_PATH" >> ${LIBTORCH}/sourceme.sh

if grep -Fxq ". ${LIBTORCH}/sourceme.sh" "$HOME/.bashrc"; then
    echo "Libtorch source me already in .bashrc, skipping."
else
    echo ". ${LIBTORCH}/sourceme.sh" >> $HOME/.bashrc
    echo "Successfully added libtorch source me to .bashrc"
fi  

source $HOME/.bashrc
echo "Successfully sourced .bashrc to update environment variables"