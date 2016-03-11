#!/bin/bash

# This script is executed by the node engine
# "$1" is the program tested.

arg="$1"
dir=`dirname "$arg"`
prog=`basename "$arg"`
bin=`basename "$prog" .nit`

exec 19>"$dir/trace"
export BASH_XTRACEFD=19
set -x

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
	( echo "" | timeout -k 3 3 firejail --quiet --profile=jail.profile --private="$bin" --quiet "$@" |& grep -v Firejail ) |& cat -v >> "$output"
	#echo "" | timeout -k 3 3 firejail --quiet --private="$bin" --quiet "$@" |& grep -v Firejail | cat -v >> "$output"
	#echo "" | firejail --quiet --private="$bin" --quiet "$@" |& grep -v Firejail | cat -v >> "$output"
	#echo "" | sh -c "cd $bin; $*" |& cat -v >> "$output"
}

function checkres()
{
	diff -u "$result" "$output" --label expected --label output >&2
}

function default()
{

	mv "$arg" "$dir/$file"
	compile "$file" &&
	run "./`basename "$file" .nit`" &&
	checkres &&
	flag
}

function flag()
{
	md5=(`md5sum "../$file"`)
	echo "UQAM{$md5}"
	highlight --fragment -S nit --enclose-pre "../$file" > "$dir/answer.html"
}

bin="$dir/bin"
mkdir -p "$bin"
output="$dir/output"
result="tmpls/$tmpl.res"

export CACA_DRIVER=ncurses
export CACA_GEOMETRY=40x20
export TERM=dumb

case "$tmpl" in
	01_hello)
		file="hello.nit"
		default
		;;

	02_value)
		file="value.nit"
		default
		;;

	03_control)
		file="fibonacci.nit"
		default
		;;

	03b_control)
		file="prime.nit"
		default
		;;

	04_function)
		file="hanoi.nit"
		default
		;;

	05_collection)
		file="filter.nit"
		default
		;;

	06_type)
		file="deep_first.nit"
		default
		;;
	
	class)
		file="helloo.nit"
		default 
		;;
	
	module)
		file="hacker.nit"
		mv "$arg" "$dir/$file"
		cp ../args.nit "$dir"
		compile args.nit -m "$file" &&
		run ./args some arguments &&
		checkres &&
		flag
		;;

	refinement)
		file="crypto13.nit"
		default
		;;
	
	visitor)
		cp ../bool_visitor.nit ../bool_expr.nit "$dir"
		file="bool_eval.nit"
		default
		;;

	nitcc)
		: # FLAG IS MD5
		;;
	
	nitcc_2)
		file="logolas.nit"
		mv "$arg" "$dir/$file"
		cp ../logolas_parser.nit ../logolas_test_parser.nit ../logolas_lexer.nit "$dir"
		cp ../*.logolas "$bin"
		compile "$file" &&
		run ./logolas maenas.logolas &&
		run ./logolas elen.logolas &&
		run ./logolas bar.logolas &&
		checkres &&
		flag
		;;

	ffi)
		file="fnmatch.nit"
		default
		;;
	
	ffi2)
		file="caca.nit"
		mv "$arg" "$dir/$file"
		cp ../caca_client.nit "$dir"
		compile "caca_client.nit" &&
		run "./caca_client" &&
		checkres &&
		flag
		;;

	logolas_caca)
		file="logolas_caca.nit"
		mv "$arg" "$dir/$file"
		cp ../logolas_parser.nit ../logolas_test_parser.nit ../logolas_lexer.nit ../caca.nit "$dir"
		cp ../*.logolas "$bin"
		compile "$file" &&
		run ./logolas_caca maenas.logolas &&
		run ./logolas_caca elen.logolas &&
		run ./logolas_caca bar.logolas &&
		checkres &&
		flag
		;;

	*)
		echo >&2 "FATAL ERROR: cannot process mission '$tmpl'"
		exit 1
		;;
esac
