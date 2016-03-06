

# Return the template source file associated to the input file ($1)
# If no template match, return the empty string.
function get_template()
{
	input="$1"
	for tmpl in tests/*.nit; do
		./diff "$tmpl" "$input" || continue
		echo "$tmpl"
		return 0
	done

	echo ""
	return 1
}

# Compile the input source-file ($1)
function compile()
{
	input="$1"
	nitc "$1" -o out.bin
}

# Run the compiled program
function run()
{
	./out.bin
}

# Check the result
function check()
{
	return 0
}

# Fully process a single input file ($1)
function process()
{
	i="$1"

	t=`get_template "$i"`
	if [ -z "$t" ]; then
		echo "$i: Error. no matching template found "
		continue
	fi
	b=`basename "$t" .nit`
	echo "$i -> $b"

	compile "$1"
}

for i in "$@"; do
	process "$i"
done
