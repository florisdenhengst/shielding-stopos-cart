#!/bin/bash
module load pre2019
module load stopos

stopos purge -p shielding-run
stopos create -p shielding-run
stopos add ~/projects/shielding-pydial/config/pydial_benchmarks/shielded/stopos_vals -p shielding-run
