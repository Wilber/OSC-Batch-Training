#!/bin/bash
#SBATCH --time=00:10:00
#SBATCH --ntasks=1
#SBATCH --job-name=sleepy
#SBATCH --account=PZS1010
#SBATCH -e sleepy.batch-%j.err ###%j will be replaced by the $SLURM_JOB_ID
#SBATCH -o sleepy.batch-%j.out


#slurm starts job in working DIR
cd $SLURM_SUBMIT_DIR

date

pwd
hostname
squeue --job $SLURM_JOBID

date

sleep 300
