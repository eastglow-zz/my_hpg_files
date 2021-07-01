#!/bin/sh
#SBATCH --job-name=c10            #Job name
#SBATCH --nodes=1                   #Number of nodes (servers, 32 proc/node)
#SBATCH --ntasks=16                 #Number of tasks/How many parallel jobs to run
#SBATCH --ntasks-per-node=16         #Tasks per node
#SBATCH --cpus-per-task=1           #Number of CPU per task
#SBATCH --distribution=cyclic:cyclic     #Distribute tasks cyclically 
#SBATCH --mem-per-cpu=10gb           #Memory (120 gig/node)
#SBATCH --time=12:00:00             #Walltime hh:mm:ss
#SBATCH --output=c10-%j.out #Output and error log name
#SBATCH --mail-type=ALL             #When to email user: NONE,BEGIN,END,FAIL,REQUEUE,ALL
#SBATCH --mail-user=donguk.kim@ufl.edu       #Email address to send mail to
#SBATCH --qos=michael.tonks                #Allocation group name, add -b for burst job
##SBATCH --array=1-200%10           #Used to submit multiple jobs with one submit

#APPPATH=/home/donguk.kim/projects/moose/modules/phase_field
APPPATH=/home/donguk.kim/projects/moose/modules/combined
#srun --mpi=pmix_v1 $APPPATH/coupling_xolotl-opt -i $APPPATH/PFmulti_bubble_master_large.i
#srun --mpi=pmix_v1 $APPPATH/coupling_xolotl-opt -i ./PFmulti_bubble_master_large_updated.i
#srun --mpi=pmix_v3 $APPPATH/phase_field-opt -i ./grain_growth_2D_voronoi.i
#srun --mpi=pmix_v3 $APPPATH/phase_field-opt -i ./s2_fasttest.i
srun --mpi=pmix_v3 $APPPATH/combined-opt -i ./hetero_nucl_simplesrc.i Materials/Material_properties/prop_values='0.055 0.52 270.5 32 0.01 1000 1    8.37707e-7  0.0   1e5'
