#!/bin/bash

fasta="IVLPKLKCLLIK"
number=8
filename="4_${fasta}.pdb"
time=600

export MKL_NUM_THREADS=$number,1
export OMP_NUM_THREADS=$number
export OMP_STACKSIZE=2G
export OMP_SCHEDULE=dynamic

ulimit -s unlimited

mkdir "RESTART_1_${time}ps"
cd "RESTART_1_${time}ps"
cp ../${filename} .
cp ../mdrestart .

cat > metadyn.inp << EOF
\$md
 temp=300
 time=${time}
 step=1.0
 nvt=true
 dump=50.0
 velo=300
 shake=1
 restart=true
\$end

\$metadyn
 alp=1.2
 save=500
 kpush=0.1
\$end

\$solvation
   solvent=water
   alpb=true
\$end

\$wall
   potential=logfermi
   sphere: 400, all   # Prevent decomposition
   beta=2
\$end

EOF

start=$(date +"%H:%M:%S")


xtb ${filename} --input metadyn.inp --md --gfnff

end=$(date +"%H:%M:%S")

cat > time_log.txt << EOF
Start: ${start}
End: ${end}
EOF
