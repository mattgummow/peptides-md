#!/bin/bash 

filename="4_peptides_v6.pdb"
newname="${filename%.pdb}.xyz"

obabel $filename -O $newname



