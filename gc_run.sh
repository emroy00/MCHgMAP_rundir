#!/bin/bash
# Bash script to submit standard run to queue
 
#number of nodes to use. can set to >1 for MPI jobs (only GCHP), otherwise leave at 1 to make sure all allocated CPUs are on same node.
#SBATCH -N 1
 
#number of CPUs to utilize (this job is one task)
#SBATCH -c 31
 
#memory per node. job will crash if limit is exceeded. Default is 1G per allocated core
#SBATCH --mem=60G
 
#time limit after which the job will be killed. default time limit is 60 minutes. Specified as HH:MM:SS or D-HH:MM
#SBATCH -t 00-96:00:00
 
#partition on which to run the job (edr or fdr work well).
#SBATCH -p edr
 
#output from the job
#SBATCH -o gc_run-%j.out
#SBATCH -e gc_run-%j.err
 
#send email when job ends and fails (this functionality never worked for me)
#xSBATCH -–mail-user=emroy@mit.edu
#xSBATCH --mail-type=FAIL
#xSBATCH --mail-type=END
 
#load the GC bash
source ~/GCC.v14.bashrc
 
#point towards GEOS-Chem binary
export exepath=./gcclassic
 
#configure stack size and remove limit
ulimit -s unlimited
export OMP_STACKSIZE=400m
 
#number of CPUs
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
 
#echo
echo "running GEOS-Chem"
echo "binary path: " $exepath
echo "Directory: " $currDir
echo "Running on " $OMP_NUM_THREADS" cores"
echo "Host computer " `hostname`
echo "initiation date and time " `date +%c`
 
time ${exepath}
 
exit $?

