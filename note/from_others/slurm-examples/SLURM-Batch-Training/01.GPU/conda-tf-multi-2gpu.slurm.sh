#!/bin/sh

#SBATCH -J  multi-2gpu   	# Job name
#SBATCH -o  multi-2gpu.%j.out   # Name of stdout output file (%j expands to %jobId)
#SBATCH -p  gpu-2080ti 		# queue  name  or  partiton name
#SBATCH -t  01:30:00 		# Run time (hh:mm:ss) - 1.5 hours

#### Select  GPU
## gpu 2장
#SBATCH   --gres=gpu:2

## gpu 4장
##SBATCH   --gres=gpu:4

## 노드 지정
##SBATCH  --nodelist=n1

## 노드 지정하지않기
#SBATCH   --nodes=1

## gpu 가 2장이면  --ntasks=2, --tasks-per-node=2 , --cpus-per-task=1
## gpu 가 4장이면  --ntasks=4, --tasks-per-node=4 , --cpus-per-task=1

#SBTACH   --ntasks=2
#SBATCH   --tasks-per-node=2
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

##  Python  Virtual Env ## 
# conda environments:
#
##  base                  *  /home/testuser2/anaconda3
##  tf-gpu-py36              /home/testuser2/anaconda3/envs/tf-gpu-py36
##  tf-gpu-py37              /home/testuser2/anaconda3/envs/tf-gpu-py37

echo "Start" 
echo "conda PATH "

echo "source  $HOME/anaconda3/etc/profile.d/conda.sh"
source $HOME/anaconda3/etc/profile.d/conda.sh

echo "conda activate tf-gpu-py36 " 
conda activate  tf-gpu-py36  

SAMPLES_DIR=$HOME/TensorFlow-2.x-Tutorials/
python3  $SAMPLES_DIR/03-Play-with-MNIST/main.py

date

echo " conda deactivate tf-gpu-py36  "

conda deactivate   

squeue  --job  $SLURM_JOBID 

echo  "##### END #####" 
