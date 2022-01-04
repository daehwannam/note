#!/bin/sh

#SBATCH -J  nccl-multi-gpu   	# Job name
#SBATCH -o  nccl-multi-gpu.%j.out    # Name of stdout output file (%j expands to %jobId)
#SBATCH -p gpu-titanxp     		# queue  name  or  partiton name gpu-titanxp, gpu-2080ti 
#SBATCH -t 01:30:00 		# Run time (hh:mm:ss) - 1.5 hours

#### Select  GPU       

## gpu 2장 
#SBATCH   --gres=gpu:2

## gpu 4장          
##SBATCH   --gres=gpu:4         

## 노드 지정  
##SBATCH  --nodelist=n1

## 노드 지정하지않기  
#SBATCH   --nodes=1 

## gpu 가 두장이면  ntasks=2, --tasks-per-node=2 , --cpus-per-task=2
## gpu 가 4장이면  ntasks=4, --tasks-per-node=4 , --cpus-per-task=4 

#SBTACH   --ntasks=2
#SBATCH   --tasks-per-node=2
#SBATCH   --cpus-per-task=2 



srun -l /bin/hostname  
srun -l /bin/pwd
srun -l /bin/date 

module  purge
module  load  postech-nccl-cuda10.0 

NCCL_TEST_DIR=$HOME/nccl-tests/
CMD=$NCCL_TEST_DIR/build/all_reduce_perf
# nThread 1 nGpus 2 minBytes 32 maxBytes 1073741824 step: 4(factor) warmup iters: 10 iters: 40 validation: 1
$CMD -b 32 -e 1024M -f 4  -g 2  -n 40  -w 10  -m 4
#$CMD -b 8 -e 256M -f 2 -g 2


date

squeue  --job  $SLURM_JOBID

echo  "##### END #####" 
