#!/bin/bash
#SBATCH -t 60:00:00
#SBATCH -N 1
#SBATCH --mail-user=florisdenhengst@gmail.com
#SBATCH --mail-type=ALL

module load pre2019
module load python/2.7.9

cd "$TMPDIR"
rm -rf pydial
cp -r "${HOME}/projects/shielding-pydial" .
cp -r ${HOME}/projects/shielding-stopos/*.sh .
rm -rf _benchmarklogs/*
rm -rf _benchmarkpolicies/*

nprocs=24
for i in `seq 1 $nprocs`; do
	./task.sh &
done
wait

rm -rf pydial
