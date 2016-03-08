
`{
#include <string.h>
`}

redef class String
	fun strchr(c: Char): Int import to_cstring `{
		char *str = String_to_cstring(self);
		char *res = strchr(str, c);
		if (res==NULL) return -1;
		return res - str;
	`}
end

print "Hello, World!".strchr('W')
print "Hello, World!".strchr('*')
