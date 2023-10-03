#!/bin/bash
#SBATCH --job-name=Rmpi
#SBATCH --time=00:20:00
#SBATCH --nodes=2
#SBATCH	--ntasks-per-node=28
#SBATCH -A PZS1010
#SBATCH -e Rmpi.batch-%j.err ###%j will be replaced by the $SLURM_JOB_ID
#SBATCH -o Rmpi.batch-%j.out

set echo

#
cd $SLURM_SUBMIT_DIR

ml gnu/9.1.0
ml openmpi/1.10.7
ml mkl/2019.0.5
ml R/4.0.2

# parallel R: submit job with one MPI parent process
mpirun -np 1 R --slave < Rmpi.R

sleep 300

