#!/bin/bash

# Must have the correct solvation parameter in the current working directory 
export DFTBPLUS_PARAM_DIR="$(pwd)"

#Set number of OMP threads
export OMP_NUM_THREADS=16
export OMP_STACKSIZE=1G
ulimit -s unlimited


rm -r "test"
mkdir "test"
cd "test"
cp ../geom.out.xyz .
cp ../dftb_in.hsd .
cp ../plumed.dat .
cp ../deeptica_cv1_lag100.ptc .



dftb+