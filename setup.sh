#!/bin/bash

printf "\n\e[93m=== Plexus v0.5 - Developed by Robert Thomas ==="
printf "\n=== https://github.com/Wolveix/plexus ==="
printf "\n\e[32mInstalling plexus...\n\e[94m"
mv plexus/plexus /usr/local/bin/
printf "\n\e[32mPlexus has been successfully installed. Please run 'plexus install' to continue.\n\n"
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
rm -rf $script_dir && cd