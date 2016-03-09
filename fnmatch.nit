module fnmatch

`{
#include <string.h>
#include <fnmatch.h>
`}

redef class String 
	fun fnmatch(match: String): Bool import to_cstring `{
		char *cself = String_to_cstring(self);
		char *cmatch = String_to_cstring(match);

		return fnmatch(cmatch, cself, 0) == 0;
	`}
end

print "mpire.nit".fnmatch("*.nit")
print "mpire.nit".fnmatch("*.zip")
