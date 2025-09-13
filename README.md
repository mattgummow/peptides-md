# Metadynamics of peptides along ML collective variables

GitHub repo for investigating the effectiveness of machine learning models at learning the underlying modes which contribute to peptide aggregation. 

---
## Overall Workflow 

Research question: Are collective variables learned by neural networks better than standard collective variables at accelerating the sampling of peptide aggregation?

In order to investigate whether an ML model can learn the underlying dynamics of a peptide's states of aggregation, and consequently be used to accelerate the sampling of aggregation, the model must be trained on initial simulation data. Once the model is trained, it can be tested using simulations at high levels of theory and benchmarked against other collective variables.

(1) Preprocessing is the first step, followed by (2) initial simulations. These generate training data for (3) machine learning model training, before (4) final simulations.

---

## Repository Structure

The repo is split into four parts corresponding to the four parts of the workflow for training and testing a machine-learned collective variable for peptide aggregation.

```bash
project-root/
├── dftb/        # Final DFTB+ simulations
├── mlcolvar/        # ML model training
├── xtb/        # Initial xtb simulations
├── prepro/        # Preprocessing for xtb simulations
├── env.yml/        # Conda env for running the xtb simulations and notebooks within /mlcolvar
└── README.md
```

---

## (1) Preprocessing

A starting molecular geometry file must be created for the initial simulations, which should contain copies of the relevant peptide. The file `prepro.ipynb` creates this box, with the only modification required being the changing of the fasta sequence in the second cell box; this should be changed to the sequence of the relevant peptide.

This code creates a box of four of the peptides with random orientations and saves this with file name `4_{fasta}.pdb`. Because of the random orientations, peptides can still end up in very close proximity to each other, and you should therefore visualise the .pdb file generated in VMD/PyMOL to verify the peptides are a suitable distance from one another. Further, depending on your peptide size you should change the radius parameter accordingly.

## (2) xTB simulations

xTB simulations generate training data for the machine learning models, which enables the models to learn the underlying dynamics which contribute to peptide aggregation. 

Because of this, the initial simulations must sample aggregation. In order to sample aggregation in the initial simulations, RMSD-based metadynamics is performed. RMSD-based metadynamics stores previous molecular geometries of the simulation, and pushes the simulation away from these geometries using 'gaussian hills' (adding potential energy to the system to encourage the system to escape relative energy minima). This enhanced sampling technique is built into xTB. Notably, xTB also uses an implicit solvation model.

The xTB folder contains `initial_run` and `restart_run` sub-folders - these are template scripts for running the xtb rmsd metadynamics on cx3. Each folder contains a `.pbs` and a `.sh`. The shell script contains the parameters for runing the xTB code; the only parameters that need to be changed are the FASTA sequence and the size of the spherical wall potential. Because of the implicit solvent model, there is no simulation 'box', so the wall potential keeps the peptides close together; to estimate the size of the wall potential, one should run the shell script locally and examine how the total energy changes over the first few picoseconds - large changes in energy indicate the wall size is too small.

The `restart_run` sub-folder contains a template for however many restart runs you want to perform; make sure to adjust the total time of the simulation to stay within the wall time of the `.pbs` script, and copy the mdrestart from the previous run into the directory that your `.pbs` and `.sh` files are in.

The output `.trj` files of the simulations can be viewed in VMD. Enough time should be simulated to sample ample aggregation events (i.e., monomer, dimer, trimer, and tetramer formations). The `.trj` files from the various restart runs can be concatenated using the `cat` shell command. Once concatenated, the data is ready for training a neural network. 


## (3) mlcolvar

To use the Python library `mlcolvar` to train a machine learning model of initial simulation data, and compile it such that it can be used as a collective variable for final simulation runs, the simulation data produced by (2) xTB simulations must be manipulated. `PLUMED` must be used to parse the simulation data and generate initial collective variables, which the neural network will learn from. 

The `preprocessing.ipynb` notebook takes the final, concatenated simulation trajectory file and a .pdb file of the peptide system, where importantly each peptide must be separated by 'TER' (see example files in the folder). The code outputs a `plumed.dat` file and subsequently a `COLVAR` file with CVs of phi/psi angles for each alpha carbon and distances between all alpha carbons. The code works independent of amount of amino acids in peptides, with the only requirement being that there is 'TER' between the peptides in the .pdb file.

The second file in the folder, `deeptica.ipynb`, takes the generated `COLVAR` file and produces a PyTorch compiled version of the machine learning model, ready for use outside of Python with the DFTB+ simulation software. 

## (4) DFTB+ simulations


