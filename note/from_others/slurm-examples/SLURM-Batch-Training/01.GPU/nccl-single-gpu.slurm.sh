#!/bin/sh

#SBATCH -J  nccl-gpu   	 # Job name
#SBATCH -o  nccl-single-gpu.%j.out    # Name of stdout output file (%j expands to %jobId)
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
module  load  postech-nccl-cuda10.0   

NCCL_TEST_DIR=$HOME/nccl-tests/
CMD=$NCCL_TEST_DIR/build/all_reduce_perf 
# nThread 1 nGpus 1 minBytes 32 maxBytes 1073741824 step: 4(factor) warmup iters: 10 iters: 40 validation: 1
$CMD -b 32 -e 1024M -f 4  -g 1  -n 40  -w 10  -m 4  
#$CMD -b 8 -e 256M -f 2 -g 4

date

squeue  --job  $SLURM_JOBID 

echo  "##### END #####" 
