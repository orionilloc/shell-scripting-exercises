#!/usr/bin/env bash
#
# SCRIPT: part2-ch11-random-file-generator.sh
# AUTHOR: Randy Michael / Refactor by Collin Sterne
# DATE:   2026-04-18
# REV:    1.0
#
# PLATFORM: Not Platform Dependent
#
# PURPOSE: This script creates a specific size file of random characters.
#          It uses /dev/urandom directly to build the OUTFILE of a 
#          specified MB size, bypassing traditional shell loops.
#
##########################################################
# DEFINE FILES AND VARIABLES HERE
##########################################################

typeset -i MB_SIZE=$1
WORKDIR=/scripts
OUTFILE=${WORKDIR}/largefile.random.txt
>$OUTFILE
THIS_SCRIPT=$(basename $0)

##########################################################
# DEFINE FUNCTIONS HERE
##########################################################

elapsed_time ()
{
    SEC=$1
    (( SEC < 60 )) && echo -e "[Elapsed time: $SEC seconds]\c"
    (( SEC >= 60 && SEC < 3600 )) && echo -e "[Elapsed time: $(( SEC / 60 )) min $(( SEC % 60 )) sec]\c"
    (( SEC > 3600 )) && echo -e "[Elapsed time: $(( SEC / 3600 )) hr $(( (SEC % 3600) / 60 )) min $(( (SEC % 3600) % 60 )) sec]\c"
}

usage ()
{
    echo -e "\nUSAGE: $THIS_SCRIPT Mb_size"
    echo -e "Where Mb_size is the size of the file to build\n"
}

##########################################################
# BEGINNING OF MAIN
##########################################################

if (( $# != 1 ))
then
    usage
    exit 1
fi

case $MB_SIZE in
    [0-9]*) : 
    ;;
    *) usage
       exit 1
    ;;
esac

echo "Building a $MB_SIZE MB random character file ==> $OUTFILE"
echo "Please be patient, this may take some time to complete..."
echo -e "Executing: .\c"

# Reset the shell SECONDS variable to zero seconds.
SECONDS=0

# Implementation using /dev/urandom stream directly
# This bypasses the shell loop and array overhead to fulfill the performance comparison
head -c $(( MB_SIZE * 4000000 )) /dev/urandom | tr -dc 'A-Za-z0-9' | head -c $(( MB_SIZE * 1048576 )) > $OUTFILE

# Capture the total seconds
TOT_SEC=$SECONDS

echo -e "\n\nSUCCESS: $OUTFILE created at $MB_SIZE MB\n"
elapsed_time $TOT_SEC

# Calculate the bytes/second file creation rate
if (( TOT_SEC > 0 ))
then
    (( MB_SEC = ( MB_SIZE * 1024000 ) / TOT_SEC ))
    echo -e "\n\nFile Creation Rate: $MB_SEC bytes/second\n"
else
    echo -e "\n\nFile Creation Rate: Fast enough to be unmeasured\n"
fi

echo -e "File size:\n"
ls -l $OUTFILE
echo

##########################################################
# End of script
