#!/bin/sh
#PBS -N ocr
#PBS -m be
#PBS -j oe
#PBS -l walltime=24:00:00
#PBS -l nodes=1:ppn=20

#lscpu
cd $PBS_O_WORKDIR
junest -p "-k 3.10" -- make
