#!/bin/bash
#SBATCH --nodes 3
#SBATCH --ntasks-per-node=40
#SBATCH --time=6:00:00
#SBATCH --job-name=LES
#SBATCH --output=mpi_output_%j.txt
#SBATCH --mail-type=ALL

cd ~/scratch/n/ngrisoua/zemskova/turbChannel_LES

module load intel
module load intelmpi

~/Nek5000/bin/nekmpi turbChannel 120

