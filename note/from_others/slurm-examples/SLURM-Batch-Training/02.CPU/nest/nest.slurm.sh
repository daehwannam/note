#!/bin/bash

#SBATCH  -J nest
#SBATCH  -o nest.%j.out
#SBATCH  -t 01:00:00

## cpu queue, node   지정 ##  
## cpu queue  cpu-i7,cpu-xg6230,cpu-xs4114-12c 
#SBATCH  -p cpu-xs4114-12c      
#SBATCH  --nodelist=n18     ## cpu-xs4114-12c  queue  node  n[15-18]  
#SBATCH  --nodes=1
#SBATCH  --ntasks-per-node=1
#SBATCH  --cpus-per-task=1


set echo on

echo "SLURM_SUBMIT_DIR=$SLURM_SUBMIT_DIR"

srun -l /bin/hostname
srun -l /bin/pwd
srun -l /bin/date

# run the application
module  purge  
module  load postech 

cd $SLURM_SUBMIT_DIR 


gcc nest.c -lm 

date 

./a.out 45900 12100   

date 

rm -f a.out

squeue --job $SLURM_JOBID

