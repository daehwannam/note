if [ -z "$1" ]
then
    NCPU=1
else
    NCPU=$1
fi

qsub -I -l select=1:ncpus=$NCPU -l walltime=12:00:00 -q debug -A etc
