var tmpl_path = args[0]
var input_path = args[1]

var tmpl = tmpl_path.to_path.read_lines
var input = input_path.to_path.read_lines

#print "tmpl:{tmpl.length}"
#print "input:{input.length}"

var ili = 0
for tli in [0..tmpl.length[ do

	# Get template line
	var tl = tmpl[tli].trim
	if tl == "# CHANGE BELLOW" then break
	if tl == "# CODE HERE" then break
	if tl.is_empty then continue

	# Get input line
	var il
	loop
		if ili >= input.length then
			stderr.write "top: no more input line {ili} for the template line {tli}\n"
			exit 1
		end
		il = input[ili].trim
		if il.is_empty then
			ili += 1
			continue
		end
		break
	end

	if tl != il then
		stderr.write "top: different template line {tli} vs input {ili}. `{tl}` vs. `{il}`\n"
		exit 1
	end

	ili += 1
end

ili = 0
for tli in [0..tmpl.length[ do
	# Get template line
	var tl = tmpl[tmpl.length-1-tli].trim
	if tl == "# CHANGE ABOVE" then break
	if tl == "# CODE HERE" then break
	if tl.is_empty then continue

	# Get input line
	var il
	loop
		if ili >= input.length then
			stderr.write "bot: no more input line {ili} for the template line {tli}\n"
			exit 1
		end
		il = input[input.length-1-ili].trim
		if il.is_empty then
			ili += 1
			continue
		end
		break
	end

	if tl != il then
		stderr.write "bop: different template line {tli} vs input {ili}. `{tl}` vs. `{il}`\n"
		exit 1
	end
	ili += 1
end

exit 0
