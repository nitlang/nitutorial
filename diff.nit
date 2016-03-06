var tmpl_path = args[0]
var input_path = args[1]

var tmpl = tmpl_path.to_path.read_lines
var input = input_path.to_path.read_lines

#print "tmpl:{tmpl.length}"
#print "input:{input.length}"

for line in [0..tmpl.length[ do
	var tl = tmpl[line].trim
	if tl == "# CHANGE BELLOW" then break

	if line >= input.length then exit 1
	var il = input[line].trim

	if tl != il then exit 1
end

for line in [0..tmpl.length[ do
	var tl = tmpl[tmpl.length-1-line].trim
	if tl == "# CHANGE ABOVE" then break

	if line >= input.length then exit 1
	var il = input[input.length-1-line].trim
	if tl != il then exit 1
end

exit 0
