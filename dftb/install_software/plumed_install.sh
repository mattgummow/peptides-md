#!/bin/bash

cd
rm -rf plumed2

if grep -Fxq ". /home/mjg120/plumed2/sourceme.sh" "$HOME/.bashrc"; then
    sed -i "\|. /home/mjg120/plumed2/sourceme.sh|s|^|# |" "$HOME/.bashrc"
fi

echo "Cloning PLUMED2 developer version github repository"
git clone https://github.com/plumed/plumed2.git
echo "Successfully cloned repository"

cd plumed2
./configure --enable-libtorch --enable-modules=pytorch --disable-mpi --disable-gsl --prefix=$HOME/opt
make -j4
make install
source sourceme.sh
cd ..
echo ". $PWD/plumed2/sourceme.sh" >> $HOME/.bashrc