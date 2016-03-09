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
#set -x

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
	cd "$dir"
	nitc --no-color "$@" --dir bin
	res=$?
	cd "$OLDPWD"
	test "$res" = "0"
}

function run()
{
	echo "" | timeout -k 3 3 firejail --quiet --profile=jail.profile --private="$bin" --quiet $@ | grep -v Firejail >> "$output"
}

function default()
{

	mv "$arg" "$dir/$file"
	compile "$file" &&
	run ./`basename "$file" .nit` &&
	diff -u "$result" "$output" >&2
}

bin="$dir/bin"
mkdir -p "$bin"
output="$dir/output"
result="tmpls/$tmpl.res"

case "$tmpl" in
	01_hello)
		file="hello.nit"
		default &&
		echo "UQAM{FLAG$tmpl}"
		;;

	02_value)
		file="value.nit"
		default &&
		echo "UQAM{FLAG$tmpl}"
		;;

	03_control)
		file="fibonnaci.nit"
		default &&
		echo "UQAM{FLAG$tmpl}"
		;;

	03b_control)
		file="prime.nit"
		default &&
		echo "UQAM{FLAG$tmpl}"
		;;

	05_collection)
		file="filter.nit"
		default &&
		echo "UQAM{FLAG$tmpl}"
		;;

	06_type)
		file="deep_first.nit"
		default &&
		echo "UQAM{FLAG$tmpl}"
		;;
	
	class)
		file="helloo.nit"
		default &&
		echo "UQAM{FLAG$tmpl}"
		;;
	
	module)
		file="hacker.nit"
		mv "$arg" "$dir/$file"
		cp ../args.nit "$dir"
		compile args.nit -m "$file"
		;;

	
	nitcc_2)
		file="logolas.nit"
		mv "$arg" "$dir/$file"
		cp ../*.logolas "$bin" 
		cp ../logolas_parser.nit ../logolas_test_parser.nit ../logolas_lexer.nit "$dir" 
		compile "$file" &&
		run ./logolas maenas.logolas &&
		run ./logolas elen.logolas &&
		run ./logolas bar.logolas &&
		diff -u "$result" "$output" >&2 &&
		echo "UQAM{FLAG}"
		;;

	logolas_caca)
		export CACA_DRIVER=ncurses
		export CACA_GEOMETRY=40x20
		file="logolas_caca.nit"
		mv "$arg" "$dir/$file"
		cp ../*.logolas "$bin" 
		cp ../logolas_parser.nit ../logolas_test_parser.nit ../logolas_lexer.nit ../caca.nit "$dir" 
		compile "$file" &&
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
