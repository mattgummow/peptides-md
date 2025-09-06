# Metadynamics of peptides along ML collective variables

GitHub repo for investigating the effectiveness of machine learning models at learning the underlying modes which contribute to peptide aggregation. 

---
## Overall Workflow 

To investigate whether an ML model can learn the underlying dynamics of a peptide's states of aggregation, and consequently be used to acclerate the sampling of aggregation, the model must be trained on initial simulation data. Once the model is trained, it can be tested using simulations at higher levels of theory and benchmarked against other collective variables.

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

---

## (2) xTB simulations

---

## (3) mlcolvar

---

## (4) DFTB+ simulations

---
