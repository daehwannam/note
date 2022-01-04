#!/bin/sh

#SBATCH -J  multi-4gpu   	# Job name
#SBATCH -o  multi-4gpu.%j.out    # Name of stdout output file (%j expands to %jobId)
#SBATCH -t  01:30:00 		# Run time (hh:mm:ss) - 1.5 hours

#### Select  GPU       
#SBATCH -p gpu-titanxp    	# queue  name  or  partiton name gpu-titanxp, gpu-2080ti 

## gpu 2장 
##SBATCH   --gres=gpu:2

## gpu 4장          
#SBATCH   --gres=gpu:4         

## 노드 지정  
##SBATCH  --nodelist=n1

## 노드 지정하지않기  
#SBATCH   --nodes=1 

## gpu 가 2장이면  --ntasks=2, --tasks-per-node=2 , --cpus-per-task=1
## gpu 가 4장이면  --ntasks=4, --tasks-per-node=4 , --cpus-per-task=1 

#SBTACH   --ntasks=4
#SBATCH   --tasks-per-node=4
#SBATCH   --cpus-per-task=1

cd  $SLURM_SUBMIT_DIR

echo "SLURM_SUBMIT_DIR=$SLURM_SUBMIT_DIR"
echo "CUDA_HOME=$CUDA_HOME"
echo "CUDA_VISIBLE_DEVICES=$CUDA_VISIBLE_DEVICES"
echo "CUDA_VERSION=$CUDA_VERSION"


srun -l /bin/hostname  
srun -l /bin/pwd
srun -l /bin/date 

module  purge  
module  load   postech  


SAMPLES_DIR=$HOME/TensorFlow-2.x-Tutorials/
python3  $SAMPLES_DIR/03-Play-with-MNIST/main.py 

date

squeue  --job  $SLURM_JOBID

echo  "##### END #####" 
