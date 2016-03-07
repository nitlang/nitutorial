# Files

Files manipulation are done by the library. Here a sample of the hi-level (good) stuff.

~~~nit
# Write a file
"Hello\nWorld\n".write_to_file "hello.txt"

var path = "hello.txt".to_path
# Read a file
var txt = path.read_all
assert txt == "Hello\nWorld\n"

# Read the lines of a file
var lines = path.read_lines
print lines.join("|")
assert lines == ["Hello", "World"]

# Read the line of a file, one line at the time
for l in path.each_line do
	print l
end
~~~

