#!/bin/sh
#SBATCH --job-name=M1e4            #Job name
#SBATCH --nodes=1                   #Number of nodes (servers, 32 proc/node)
#SBATCH --ntasks=32                 #Number of tasks/How many parallel jobs to run
#SBATCH --ntasks-per-node=32         #Tasks per node
##SBATCH --cpus-per-task=1           #Number of CPU per task
#SBATCH --mem-per-cpu=1gb           #Memory (120 gig/node)
#SBATCH --time=024:00:00             #Walltime hh:mm:ss
#SBATCH --output=US-%j.out #Output and error log name
#SBATCH --mail-type=ALL             #When to email user: NONE,BEGIN,END,FAIL,REQUEUE,ALL
#SBATCH --mail-user=donguk.kim@ufl.edu       #Email address to send mail to
#SBATCH --qos=michael.tonks                #Allocation group name, add -b for burst job
##SBATCH --array=1-200%10           #Used to submit multiple jobs with one submit

srun --mpi=pmix_v1 /home/donguk.kim/projects/wetting/wetting-opt -i ./INS_MPCH_coupled_flat.i
