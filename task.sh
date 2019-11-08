#!/bin/bash
module load pre2019
module load stopos
module load python/2.7.9

source ~/venvs/pydial/bin/activate
PYDIAL_BASE="${TMPDIR}/shielding-pydial/"
CONF_DIR="${PYDIAL_BASE}config/pydial_benchmarks/shielded/"
PYDIAL_COMMAND="time python ${PYDIAL_BASE}pydial.py train"
STOPOS_BASE="${HOME}/projects/shielding-stopos/"
STDOUT_DIR="${HOME}/projects/shielding-stopos/results/stdout/${SLURM_ARRAY_JOB_ID}"
STDERR_DIR="${HOME}/projects/shielding-stopos/results/stderr/${SLURM_ARRAY_JOB_ID}"

mkdir -p "$STDOUT_DIR"
mkdir -p "$STDERR_DIR"

STOPOS_RC="OK"
stopos -p shielding-run next
echo "STOPOS_RC: $STOPOS_RC"
if [ "$STOPOS_RC" == "OK" ]; then
	a=( $STOPOS_VALUE )
	echo $a
	config=${a[0]}
	echo $config
	logglob=${a[1]}
	echo $logglob
	command="$PYDIAL_COMMAND ${CONF_DIR}${config} > out.log"
	echo "$command"
	pushd $PYDIAL_BASE
	$(eval $command)
	popd
	cp ${PYDIAL_BASE}/_benchmarklogs/${logglob} ${STDOUT_DIR}
	cp ${TMPDIR}/out.log ${STDOUT_DIR}
	cp ${TMPDIR}/${stderr_target} ${STDERR_DIR}
	stopos remove -p shielding-run
fi
