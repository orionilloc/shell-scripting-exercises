#!/usr/bin/env bash
#
# SCRIPT: part2-ch11-128char-encryption-key.sh
# AUTHOR: Collin Sterne
# DATE:   2026-04-18
# REV:    1.2
#
# PLATFORM: Linux (Debian 12 / Ubuntu / RHEL)
#
# PURPOSE: Generates a 128-character high-entropy encryption key
#          using the blocking /dev/random device and a diverse 
#          character set.
#
##########################################################
# DEFINE FILES AND VARIABLES HERE
##########################################################

# No global variables needed for this generation

##########################################################
# DEFINE FUNCTIONS HERE
##########################################################

generate_128_char_key() {
    local encryption_key

    # Grabbing 1024 bytes to ensure we have enough entropy 
    # after filtering through tr for special characters.
    encryption_key=$(head -c 1024 /dev/random | tr -dc 'A-Za-z0-9!@#$%^&*()_+' | head -c 128)

    if [[ ${#encryption_key} -lt 128 ]]; then
        echo "Error: Failed to generate full 128-character key." >&2
        return 1
    fi

    echo "$encryption_key"
}

##########################################################
# BEGINNING OF MAIN
##########################################################

echo "128 character encryption key generated below:"
echo ""

generate_128_char_key

##########################################################
# End of script
