#!/usr/bin/env bash
#
# SCRIPT: part2-ch11-rng.sh
# AUTHOR: Collin Sterne
# DATE:   2026-04-18
# REV:    1.3
#
# PLATFORM: Linux / Not platform dependent
#
# PURPOSE: Generate 1,000 random numbers using three different methods 
#          to compare shell variables, /dev/urandom, and /dev/random 
#          using the time utility.
#
##########################################################
# DEFINE FILES AND VARIABLES HERE
##########################################################

# No global variables needed for this benchmark

##########################################################
# DEFINE FUNCTIONS HERE
##########################################################

RANDOM_shell_generation() {
    RANDOM_counter=1
    until [[ $RANDOM_counter -gt 1000 ]]
    do
        echo $RANDOM
        ((RANDOM_counter++))
    done
}

dev_urandom_generation() {
    dev_urandom_counter=1
    until [[ $dev_urandom_counter -gt 1000 ]]
    do
        head -c 2 /dev/urandom | od -An -tu2
        ((dev_urandom_counter++))
    done
}

dev_random_generation() {
    dev_random_counter=1
    until [[ $dev_random_counter -gt 1000 ]]
    do
        head -c 2 /dev/random | od -An -tu2
        ((dev_random_counter++))
    done
}

##########################################################
# BEGINNING OF MAIN
##########################################################

# Method 1: Internal Shell Variable
time RANDOM_shell_generation > /dev/null

# Method 2: Non-blocking device file
time dev_urandom_generation > /dev/null

# Method 3: Blocking device file
time dev_random_generation > /dev/null

# End of script
