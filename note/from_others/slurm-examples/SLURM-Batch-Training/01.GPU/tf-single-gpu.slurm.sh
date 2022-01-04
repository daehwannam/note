#!/bin/sh

#SBATCH -J  single-gpu   	 # Job name
#SBATCH -o  single-gpu.%j.out    # Name of stdout output file (%j expands to %jobId)
#SBATCH -t  01:30:00 		 # Run time (hh:mm:ss) - 1.5 hours

#### Select  GPU       
#SBATCH -p  gpu-titanxp     	 # queue  name  or  partiton name  gpu-titanxp ,gpu-2080ti 

#SBATCH   --gres=gpu:1         

##node  지정하지 않고 던지기 
#SBATCH   --nodes=1 
#SBATCH   --tasks-per-node=1
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
module  load  postech 

SAMPLES_DIR=$HOME/TensorFlow-2.x-Tutorials/
python3  $SAMPLES_DIR/03-Play-with-MNIST/main.py 

date

squeue  --job  $SLURM_JOBID 


echo  "##### END #####" 
