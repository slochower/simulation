#!/bin/bash
#PBS -l walltime=96:00:00,nodes=1:ppn=4:gpupair -q home-gibbs
#PBS -j oe -r n -m a -M slochower@gmail.com
#PBS -N hiv-protease-apo

module swap intel gnu
module load cuda
module load python
module load scipy/2.7

PATH="/home/henrikse/gnu44-bin:/opt/mvapich2/gnu/ib/bin:$PATH"
CUDA_HOME="/opt/cuda/7.5.18"
LD_LIBRARY_PATH="${CUDA_HOME}/lib64:/opt/mvapich2/gnu/ib/lib:$LD_LIBRARY_PATH"
MV2_ENABLE_AFFINITY=0
SCRDIR=/oasis/tscc/scratch/davids4/hiv-protease/
source /home/henrikse/amber16gnu/tsccamber.sh

# Synchronize all the files in the current directory with the scratch directory
mkdir -p $SCRDIR
rsync -avL $PBS_O_WORKDIR $SCRDIR

# Run the super duper python script
cd $SCRDIR/1hhp_apo
python3 tscc-equilibrate.py
