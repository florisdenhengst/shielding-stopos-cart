#!/bin/bash

module load pre2019
module load stopos

#NR_LINES=9720
#NR_NODES=608
NR_NODES=50 # +1

sbatch -a 0-$NR_NODES ./job.sh
