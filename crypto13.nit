module crypto13

import crypto

redef fun print(value)
do
	var text = value.to_s
	super text.rot(13)
end

print "Hello, World!"
print "Goodbye, World!"
