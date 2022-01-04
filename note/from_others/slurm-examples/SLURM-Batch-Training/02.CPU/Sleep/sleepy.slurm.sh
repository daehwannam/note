#!/bin/bash  
#SBATCH  -J sleepy 
#SBATCH  -o sleepy.%j.out
#SBATCH  -t 00:05:30
#SBATCH  --nodes=1 
#SBATCH  --ntasks=2
#SBATCH  --tasks-per-node=2
#SBATCH  --cpus-per-task=1 

set echo on

cd  $SLURM_SUBMIT_DIR
echo "SLURM_SUBMIT_DIR=$SLURM_SUBMIT_DIR"

srun -l /bin/hostname
srun -l /bin/pwd
srun -l /bin/date

module  purge
module  load  postech

date 

sleep 120 

date

squeue --job $SLURM_JOBID

