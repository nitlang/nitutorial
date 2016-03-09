#!/bin/bash

# This script is executed by the node engine
# "$1" is the program tested.

set -e
#set -x

arg="$1"
dir=`dirname "$arg"`
prog=`basename "$arg"`
bin=`basename "$prog" .nit`

(
	cd "$dir"
	nitc --no-color "$prog" -o "$bin" || exit 1
)
TERM= timeout -k 3 3 firejail --quiet --profile=jail.profile --private="$dir" --quiet "./$bin"
