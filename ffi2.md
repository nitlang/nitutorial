# Wrapping Libraries

Nit can provide an automatic wrapping of extern date structure as classes.
Theses class are declared `extern`.

The goal of extern class is to describe data that live in the foreign language.
Like a normal class, an extern class can define, inherit and redefine methods.
Methods can event be foreign or pure Nit.
The only restriction is that extern class cannot have attributes (data lives in the foreight world) and can only specializes interfaces or other extern classes.

The advantage of extern class is that the values are no more opaque in the exterm methods.
When an extern class is used to type a parameter or the return value of an extern method,
then the value is directly accessible.

The foreign type is indicated after the class name with the now traditional back-quoted curly-bracket notation.

~~~nit
`{
#include <sys/types.h>
#include <dirent.h>
`}

extern class CDir `{ DIR* `}
        # Open a directory
        new opendir(path: NativeString) `{ return opendir(path); `}

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
	if ent.is_null then break
	print ent.to_s
end
dir.closedir
~~~

Some included foreign code may require specific flag to compile them.
These flags can be declared in the module declaration.

Most of the time for C and C++ foreign code, the tool `pkg-config` can be used to correctly get these flags.

~~~nit
module curl is pkgconfig

# Rest of the code...
~~~

## Mission

Write a simple wrapper around [libcaca](http://caca.zoy.org/doxygen/libcaca/caca_8h.html) that include the following data types and functions:

You need to wrap the following:

* `` as `CadaDisplay`
* `` as `CadaDisplay::display`
* `` as `CadaDisplay::refresh`
* `` as `CacaCanvas`
* `` as `CacaCanvas::put`

Also add a `CadaDisplay::quit` that waits for any input event then destroy the display.

~~~nit
module caca_client

import caca

var d = new CacaDisplay
var c = d.canvas
c.put("Hello, World!", 5, 1)
d.refresh
d.quit
~~~

Look at the tutorial and the header file for information.

### Template to Use

~~~nit
module caca is pkgconfig

# CODE HERE
~~~

### Expected Result

A window with "Hello, World!" at (5,1)
