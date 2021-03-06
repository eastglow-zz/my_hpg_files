#!/bin/bash
#PBS -N CR1
#PBS -M donguk.kim@ufl.edu
#PBS -m bea
#PBS -j oe
#PBS -l select=1:ncpus=1:mpiprocs=1:mem=100gb
#PBS -l walltime=08:00:0
##PBS -l place=excl
#PBS -P moose

APPPATH=$MYPRJ_DIR/MOOSE/projects/coupling_xolotl_new
RUNPATH=/home/kimdong/scratch/scaling_strong/CR
mpirun $APPPATH/coupling_xolotl_new-opt -i $RUNPATH/PFmulti_bubble_master_20um_kdec_clu_Res.i
