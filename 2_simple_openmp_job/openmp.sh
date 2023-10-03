#!/bin/bash
#SBATCH --account=PZS1010
#SBATCH --job-name=openmp
#SBATCH --time=00:10:00
#SBATCH --ntasks=8
#SBATCH -e openmp.batch-%j.err ###%j will be replaced by the $SLURM_JOB_ID
#SBATCH -o openmp.batch-%j.out


#software licenses syntax
#use: SBATCH --licenses={software flag}@osc:N
#use: SBATCH --licenses=abaqus@osc:5

cd $SLURM_SUBMIT_DIR

#compile
gcc -o hello -fopenmp openmp-hello.c

#copy to compute node  disk space
cp hello  $TMPDIR

cd $TMPDIR

export OMP_NUM_THREADS=8

#execute
./hello > hello_results

cp hello_results $SLURM_SUBMIT_DIR

sleep 300
