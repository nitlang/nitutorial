#!/bin/bash

# This script is executed by the node engine
# "$1" is the program tested.

arg="$1"
dir=`dirname "$arg"`
prog=`basename "$arg"`
bin=`basename "$prog" .nit`

exec 18>"$dir/log"
exec 19>"$dir/trace"
export BASH_XTRACEFD=19
set -x

# Return the template source file associated to the input file ($1)
# If no template match, return the empty string.
function get_template()
{
	echo "## $FUNCNAME $@" >&18
	input="$1"
	for tmpl in ../tracks/*; do
		local f=$tmpl/template.nit
		test -f "$f" || continue
		echo "--- $f ---" >&18
		./diff "$f" "$input" 2>&18 || continue
		echo "Found" >&18
		echo `basename "$tmpl" .nit`
		return 0
	done

	echo ""
	return 1
}


tmpl=`get_template "$arg"`

if [ -z "$tmpl" ]; then
	echo >&18 "No template"
	echo >&2 "Cannot identify the mission you tried to solve. Please use the template provided as is without any modification."
	exit 1
fi


function compile()
{
	echo >&18 "## $FUNCNAME $@"
	cd "$dir"
	nitc --no-color "$@" --dir bin
	res=$?
	cd "$OLDPWD"
	test "$res" = "0"
}

function run()
{
	echo >&18 "## $FUNCNAME $@"
	( echo "" | timeout -k 3 3 firejail --quiet --profile=jail.profile --private="$bin" --quiet "$@" |& grep -v Firejail ) |& cat -v >> "$output"
	#echo "" | timeout -k 3 3 firejail --quiet --private="$bin" --quiet "$@" |& grep -v Firejail | cat -v >> "$output"
	#echo "" | firejail --quiet --private="$bin" --quiet "$@" |& grep -v Firejail | cat -v >> "$output"
	#echo "" | sh -c "cd $bin; $*" |& cat -v >> "$output"
}

function checkres()
{
	echo >&18 "## $FUNCNAME $@ ; $result $output"
	diff -u "$result" "$output" --label expected --label output >&2
}

function default()
{
	echo >&18 "## $FUNCNAME $@"
	mv "$arg" "$dir/$file"
	compile "$file" &&
	run "./`basename "$file" .nit`" &&
	checkres
}

function flag()
{
	echo >&18 "## $FUNCNAME $@"
	md5=(`md5sum "../$file"`)
	echo "UQAM{$md5}"
	highlight --fragment -S nit --enclose-pre "../$file" > "$dir/answer.html"
	echo >&18 "FLAG $tmpl/$file UQAM{$md5}"
}

function bis()
{
	result="../tracks/$tmpl/result_bis.txt"
	output="$output.bis"
}

function fool()
{
	echo >&2 "Are you trying to fool us?"
	exit 1
}

function defaultbis()
{
	default || return 1
	bis
	sed -i.bak -e "$@" "$dir/$file"
	default 2> /dev/null || fool
	flag
}


bin="$dir/bin"
mkdir -p "$bin"
output="$dir/output"
result="../tracks/$tmpl/result.txt"

export CACA_DRIVER=ncurses
export CACA_GEOMETRY=40x20
export TERM=dumb

case "$tmpl" in
	01_hello)
		file="hello.nit"
		default &&
		flag
		;;

	02_value)
		file="value.nit"
		default &&
		flag
		;;

	03_control)
		file="fibonacci.nit"
		defaultbis 's/limit = 500/limit = 5000/'
		;;

	03b_control)
		file="prime.nit"
		defaultbis 's/limit = 20/limit = 33/'
		;;

	04_function)
		file="hanoi.nit"
		defaultbis 's/hanoi(5)/hanoi(7)/'
		;;

	05_collection)
		file="filter.nit"
		defaultbis 's/filter(\[35..45\])/filter([1..100])/'
		;;

	06_type)
		file="deep_first.nit"
		defaultbis 's/one = 1/one = [[[["a"]]]]/'
		;;
	
	class)
		file="helloo.nit"
		defaultbis 's/new Hello("World")/new Hello("Dome")/'
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
		defaultbis 's/print "Hello, World!"/print "DomeIsLife"/'
		;;
	
	visitor)
		cp ../bool_visitor.nit ../bool_expr.nit "$dir"
		file="bool_eval.nit"
		defaultbis 's/new BoolTrue/new BoolFalse/'
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
		checkres || exit 1
		{ bis && run ./logolas bar2.logolas && checkres; } 2>/dev/null || fool &&
		flag
		;;

	ffi)
		file="fnmatch.nit"
		defaultbis 's/mpire.nit/mpire.zip/'
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
		checkres || exit 1
		{ bis && run ./logolas_caca bar2.logolas && checkres; } 2>/dev/null || fool &&
		flag
		;;

	*)
		echo >&2 "FATAL ERROR: cannot process mission '$tmpl'"
		echo >&18 "## FATAL ERROR for $tmpl"
		exit 1
		;;
esac
