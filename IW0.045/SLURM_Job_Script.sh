#!/bin/sh
#SBATCH --job-name=IW0.045            #Job name
#SBATCH --nodes=8                   #Number of nodes (servers, 32 proc/node)
#SBATCH --ntasks=128                 #Number of tasks/How many parallel jobs to run
#SBATCH --ntasks-per-node=16         #Tasks per node
#SBATCH --cpus-per-task=1           #Number of CPU per task
#SBATCH --mem-per-cpu=7000mb           #Memory (120 gig/node)
#SBATCH --time=072:00:00             #Walltime hh:mm:ss
#SBATCH --output=US-%j.out #Output and error log name
#SBATCH --mail-type=ALL             #When to email user: NONE,BEGIN,END,FAIL,REQUEUE,ALL
#SBATCH --mail-user=donguk.kim@ufl.edu       #Email address to send mail to
#SBATCH --qos=michael.tonks                #Allocation group name, add -b for burst job
##SBATCH --array=1-200%10           #Used to submit multiple jobs with one submit

srun --mpi=pmix_v1 /home/donguk.kim/projects/wetting/wetting-opt -i /home/donguk.kim/projects/wetting/InterWidthTest/IW0.045/INS_MPCH_coupled_IW0.045.i
