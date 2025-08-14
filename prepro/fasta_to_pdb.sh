#!/bin/bash

# Conda env install #
eval "$(conda shell.bash hook)"
conda deactivate

if conda info --envs | grep -q pymol-env; then
    :
else 
    conda create -y --name pymol-env
    conda activate pymol-env
    conda install -y -c conda-forge -c schrodinger pymol-bundle 
fi


# FASTA sequence passed from jupyter notebook ##
sequence="${1}"

# Create peptide .pdb file and write to current directory #
echo "fab B${sequence}Z; save ${sequence}.pdb" | pymol -c -p

