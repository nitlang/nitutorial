#!/bin/bash

# This script is executed by the node engine
# "$1" is the program tested.

# Return the template source file associated to the input file ($1)
# If no template match, return the empty string.
function get_template()
{
	input="$1"
	for tmpl in tmpls/*.nit; do
		# echo "--- $tmpl ---"
		./diff "$tmpl" "$input" 2>/dev/null || continue
		echo `basename "$tmpl" .nit`
		return 0
	done

	echo ""
	return 1
}

#set -e
set -x

arg="$1"
dir=`dirname "$arg"`
prog=`basename "$arg"`
bin=`basename "$prog" .nit`

{
tmpl=`get_template "$arg"` >/dev/null
}
if [ -z "$tmpl" ]; then
	echo >&2 "Cannot identify the mission you tried to solve. Please use the template provided as is without any modification."
	exit 1
fi

function compile()
{
	file="$1"
	(
		cd "$dir"
		nitc --no-color "$file" --dir bin || exit 1
	)
}

function run()
{
	echo "" | timeout -k 3 3 firejail --quiet --profile=jail.profile --private="$bin" --quiet $@ | grep -v Firejail >> "$output"
}

bin="$dir/bin"
mkdir -p "$bin"
output="$dir/output"
result="tmpls/$tmpl.res"

case "$tmpl" in
	01_hello)
		file="$dir/hello.nit"
		mv "$arg" "$dir/hello.nit"
		compile "hello.nit" &&
		run ./hello &&
		diff -u "$result" "$output" >&2 &&
		echo "UQAM{FLAG}"
		;;
	
	nitcc_2)
		mv "$arg" "$dir/logolas.nit"
		cp ../*.logolas "$bin" 
		cp ../logolas_parser.nit ../logolas_test_parser.nit ../logolas_lexer.nit "$dir" 
		compile "logolas.nit" &&
		run ./logolas maenas.logolas &&
		run ./logolas elen.logolas &&
		run ./logolas bar.logolas &&
		diff -u "$result" "$output" >&2 &&
		echo "UQAM{FLAG}"
		;;

	logolas_caca)
		export CACA_DRIVER=ncurses
		export CACA_GEOMETRY=40x20
		mv "$arg" "$dir/logolas_caca.nit"
		cp ../*.logolas "$bin" 
		cp ../logolas_parser.nit ../logolas_test_parser.nit ../logolas_lexer.nit ../caca.nit "$dir" 
		compile "logolas_caca.nit" &&
		run ./logolas_caca maenas.logolas &&
		run ./logolas_caca elen.logolas &&
		run ./logolas_caca bar.logolas &&
		cat -v "$output" > "$output"2 &&
		diff -u "$result" "$output"2 >&2 &&
		echo "UQAM{FLAG}"
		;;

	*)
		echo >&2 "FATAL ERROR: cannot process mission '$tmpl'"
		exit 1
		;;
esac
