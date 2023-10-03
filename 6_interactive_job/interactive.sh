##sinteractive

#Submit a job with the default parameters
#defaults to debug partition
sinteractive -h
sinteractive -A <PROJECT_ACCOUNT>
#Run command, e.g get hostname
hostname
#Get job status
squeue -u <userName> # we are on debug partition
#Relingush job allocation
exit

##sinteractive with more arguments
sinteractive -h
sinteractive  -N 1 -n 4  -t 00:10:00  -A <PROJECT_ACCOUNT> -J test -p debug
squeue -u <userName>
scontrol show node $SLURMD_NODENAME #4 cpu allocated
exit

#Partial GPU node:
sinteractive  -N 1 -n 14 -g 1  -t 00:10:00 -p gpuserial -J gpujob -A  <PROJECT_ACCOUNT>
squeue -u <userName>
scontrol show node $SLURMD_NODENAME #gpu node, 14 CPUs allocated
exit

########################################################
########################################################

### Using salloc
##Two step
salloc --help
#Request 2 nodes, 3 ppn
salloc -A <PROJECT_ACCOUNT> -t 00:10:00  -N 1 --ntasks-per-node=3 #NOTE: still on the login node!
squeue -u <userName>

#use srun to run a shell (/bin/bash command) on an allocated node, and connect your terminal to its input and output.
srun --jobid=$SLURM_JOB_ID --pty /bin/bash #NOTE: srun syntax: srun --options command
#run your job commands.

exit

#NOTE: allocation still available even after exiting! Unlike sinteractive
squeue -u  <userName>
##REMEMBER TO REMOVE ALLOCATION!
scancel $SLURM_JOB_ID #allocation revoked
