#!/bin/bash

cwd=$PWD
echo $cwd

## Activate conda environment ## 
source $cwd/env_create.sh

## Install libtorch ## 
source $cwd/libtorch_install.sh

## Install PLUMED linked with libtorch
source $cwd/plumed_install.sh

## Install DFTB+ linked with PLUMED ## 
source $cwd/dftb_install.sh
cd