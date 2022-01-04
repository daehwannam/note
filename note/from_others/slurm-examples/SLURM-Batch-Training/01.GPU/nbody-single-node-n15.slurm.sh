#!/bin/sh
#SBATCH -J  nbody   		# Job name
#SBATCH -o  nbody.%j.out        # Name of stdout output file (%j expands to %jobId)

## CPU node  지정하기 
##SBATCH -p cpu-1     		# queue  name  or  partiton name

#SBATCH -t 01:30:00 		# Run time (hh:mm:ss) - 1.5 hours
#SBATCH --mem-per-cpu=1500 

## GPU Number ## 
#SBATCH   --gres=gpu:1

## GPU node 지정하기
#SBATCH   -p gpu-2080ti		# queue name  or  partiton name
#SBATCH   --nodelist=n15        # n[15-18] gpu-2 queue 
#SBATCH   --nodes=1
#SBATCH   --ntasks-per-node=1
#SBATCH   --cpus-per-task=1
##SBATCH   --ntasks-per-socket=1 
#SBATCH   --gres-flags=enforce-binding 


/bin/hostname  
srun -l /bin/hostname  
srun -l /bin/pwd
srun -l /bin/date 

module  purge  
module  load  postech 

cd  $SLURM_SUBMIT_DIR

echo "SLURM_SUBMIT_DIR=$SLURM_SUBMIT_DIR"
echo "CUDA_HOME=$CUDA_HOME"
echo "CUDA_VISIBLE_DEVICES=$CUDA_VISIBLE_DEVICES"
echo "CUDA_VERSION=$CUDA_VERSION"

CMD=/opt/ohpc/pub/apps/cuda-10.1/samples-bin/nbody
$CMD  -benchmark   -numbodies=1024000 
#$CMD  -benchmark  -device=1  -numbodies=1024000 
#$CMD  -benchmark  -numdevices=2  -numbodies=1024000 

date 

squeue  --job  $SLURM_JOBID  

echo  "##### END #####" 
