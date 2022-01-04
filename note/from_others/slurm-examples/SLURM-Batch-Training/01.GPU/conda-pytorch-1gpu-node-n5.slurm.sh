#!/bin/sh

#SBATCH -J  pytorch-1gpu          # Job name
#SBATCH -o  pytorch-1gpu.%j.out   # Name of stdout output file (%j expands to %jobId)
#SBATCH -p gpu-titanxp            # queue  name  or  partiton name
#SBATCH -t 01:30:00               # Run time (hh:mm:ss) - 1.5 hours

#### Select  GPU
## gpu 1장
#SBATCH   --gres=gpu:1
## gpu 2장
##SBATCH   --gres=gpu:2

## gpu 4장
##SBATCH   --gres=gpu:4

## 노드 지정
#SBATCH  --nodelist=n5

## 노드 지정하지않기
#SBATCH   --nodes=1

## gpu 가 2장이면  --ntasks=2, --tasks-per-node=2 , --cpus-per-task=1
## gpu 가 4장이면  --ntasks=4, --tasks-per-node=4 , --cpus-per-task=1

##SBTACH   --ntasks=2
##SBATCH   --tasks-per-node=2
##SBATCH   --cpus-per-task=1


cd  $SLURM_SUBMIT_DIR

echo "SLURM_SUBMIT_DIR=$SLURM_SUBMIT_DIR"
echo "CUDA_HOME=$CUDA_HOME"
echo "CUDA_VISIBLE_DEVICES=$CUDA_VISIBLE_DEVICES"
echo "CUDA_VERSION=$CUDA_VERSION"


srun -l /bin/hostname
srun -l /bin/pwd
srun -l /bin/date

## path  Erase because of the crash
module  purge
#module  load  postech

###  Python  Virtual Env ##
### conda environments:
### conda environments:
###
### base                  *  /home/testuser2/anaconda3-new
### pytorch-py37-cuda100     /home/testuser2/anaconda3-new/envs/pytorch-py37-cuda100#

echo "Start"
echo "conda PATH "

echo "source  $HOME/anaconda3-new/etc/profile.d/conda.sh"
source  $HOME/anaconda3-new/etc/profile.d/conda.sh

echo "conda activate pytorch-py37-cuda100 "
conda activate pytorch-py37-cuda100

## 1GPU test Job ##
#SAMPLES_DIR=$HOME/pytorch-examples/mnist/
SAMPLES_DIR=$HOME/pytorch-examples/word_language_model/
cd $SAMPLES_DIR
python $SAMPLES_DIR/main.py --cuda --emsize 1500 --nhid 1500 --dropout 0.65 --epochs 40 --tied

date

echo " conda deactivate pytorch-py37-cuda100 "

conda deactivate

squeue  --job  $SLURM_JOBID

echo  "##### END #####"

