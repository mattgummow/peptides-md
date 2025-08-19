#!/bin/bash

eval "$(conda shell.bash hook)"
conda deactivate
conda env create -f env.yml -n installation-env
conda activate installation-env