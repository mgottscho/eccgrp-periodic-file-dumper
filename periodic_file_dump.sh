#!/bin/bash
#
# Author: Mark Gottscho
# mgottscho@ucla.edu

ARGC=$#					# Get number of arguments excluding arg0 (the script itself). Check for help message condition.

if [[ "$ARGC" != 4 ]]; then # Bad number of arguments.
	echo "Author: Mark Gottscho"
	echo "mgottscho@ucla.edu"
	echo ""
	echo "This script periodically dumps a file in its raw form to stdout."
	echo ""
	echo "USAGE: periodic_file_dump.sh FILENAME SAMPLE_PERIOD_SEC NUM_SAMPLES OUTPUT_PATH"
	echo ""
	echo "A single --help help or -h argument will bring this message back."	exit
fi

FILENAME=$1				# Name of the file to dump
SAMPLE_PERIOD_SEC=$2	# Interval in seconds between file dumps. Note that this should be significantly longer than the time to actually read out the file.
NUM_SAMPLES=$3			# Number of complete file dump samples to collect
OUTPUT_PATH=$4			# Path to a directory to store outputs.

# Check that the file we want to dump actually exists
if [[ !(-f "$FILENAME") ]]; then
	echo "File $FILENAME does not exist!"
	exit 1
fi

# Check that the sampling period is non-negative
#if [[ $SAMPLE_PERIOD_SEC -le 0 ]]; then
#	echo "Dump period must be a positive number of seconds!"
#	exit 1
#fi

# Check that the number of samples is positive
if [[ $NUM_SAMPLES -le 0 ]]; then
	echo "Number of samples must be a positive integer."
	exit 1
fi

# Check that the output path exists
if [[ !(-d "$OUTPUT_PATH") ]]; then
	echo "Output path directory $OUTPUT_PATH does not exist!"
	exit 1
fi

# Make output directory
OUTPUT_DIR=$OUTPUT_PATH/$FILENAME.dumps
echo "Making output directory $OUTPUT_DIR"
mkdir $OUTPUT_DIR

# Dump file periodically
echo "Dumping file $FILENAME $NUM_SAMPLES times with intervals of $SAMPLE_PERIOD_SEC seconds."
for (( i=1; i<=$NUM_SAMPLES; i++ ))
do
	echo "Iteration $i"
	hexdump -v $FILENAME > $OUTPUT_DIR/$FILENAME.dump.$i
	#dd if=$FILENAME of=dumps_$FILENAME/dump.$i
	sleep $SAMPLE_PERIOD_SEC
done
