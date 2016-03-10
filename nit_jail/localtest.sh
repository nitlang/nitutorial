
for i in "$@"; do
	echo "*** $i"
	b=`basename "$i" .nit`
	d="out/local/$b"
	p="$d/prog.nit"
	rm -r "$d" 2> /dev/null
	mkdir -p "$d"
	cp "$i" "$p"
	./runtest.sh "$p"
done
