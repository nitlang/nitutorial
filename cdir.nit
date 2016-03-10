`{
#include <sys/types.h>
#include <dirent.h>
`}

extern class CDir `{ DIR* `}
        # Open a directory
        new(path: NativeString) `{ return opendir(path); `}

        # Close a directory
        fun closedir `{ closedir(self); `}

        # Read the next directory entry
        fun readdir: NativeString `{
                struct dirent *de;
                de = readdir(self);
                if (!de) return NULL;
                return de->d_name;
        `}
end

# Simple client
# Disclaimer: Usually it is often a better idea to add another API level to avoid
# the direct manipulation of foreign values.
var dir = new CDir(".".to_cstring)
loop
	var ent = dir.readdir
	if ent.address_is_null then break
	print ent.to_s
end
dir.closedir
