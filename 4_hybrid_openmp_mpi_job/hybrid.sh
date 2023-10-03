#!/bin/bash
#SBATCH --account=PZS1010
#SBATCH --job-name=hybrid
#SBATCH --time=00:10:00
#SBATCH --nodes=4
#SBATCH --ntasks-per-node=6


#Goal: run 4 MPI processes (each per node), 6 threads per node (can also request all cores per node)
module swap intel gnu


set -x

export OMP_NUM_THREADS=6
export MV2_CPU_BINDING_POLICY=hybrid

#disable processor affinity
export MV2_ENABLE_AFFINITY=0


cd $SLURM_SUBMIT_DIR

# Compile in $SLURM_SUBMIT_DIR
#mpicc -O2 -fopenmp hello-hybrid.c -o hello-hybrid
mpicc -fopenmp hello-hybrid.c -o hellohybrid

# Copy executable to all nodes
#Include filename in destination
sbcast hellohybrid $TMPDIR/hellohybrid

cd $TMPDIR
srun -n 4 --ntasks-per-node=1 hellohybrid 

sgather -k -r $TMPDIR   $SLURM_SUBMIT_DIR/my_hybrid_output

sleep 300
