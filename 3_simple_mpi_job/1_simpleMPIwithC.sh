#!/bin/bash
#SBATCH --time=00:10:00
#SBATCH --nodes=2 --ntasks-per-node=6
#SBATCH --job-name=helloMPI
#SBATCH --account=PZS1010
#SBATCH -e helloMPI.batch-%j.err ###%j will be replaced by the $SLURM_JOB_ID
#SBATCH -o helloMPI.batch-%j.out

#slurm starts job in working DIR
cd $SLURM_SUBMIT_DIR


#set up software environment
module load intel

##Run your software commands
#compile
mpicc -O2 mpi-hello.c -o helloMPI

#copy input data to local disc space $TMPDIR
#with sbcast, remember to include filename in the destination!
sbcast helloMPI $TMPDIR/helloMPI


#execute
cd $TMPDIR

srun ./helloMPI > helloMPI_results

#mpiexec ./helloSlurm > helloSlurm_results

cp helloMPI_results $SLURM_SUBMIT_DIR

sleep 300
