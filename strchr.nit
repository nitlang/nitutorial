# global FFI declaration are enclosed by `{ `}
# Use them for #include and related things.

`{
#include <string.h>
`}

# Any class can be refined with FFI method.
redef class String 
	fun strchr(c: Char): Int import to_cstring `{
		// Two parameter, `self` and `c`.
		// `self` is an opaque type in the C side
		// `c` is converted to the primitive `char`

		// Because `strchr` need a `char*`, we must convert the opaque `self`
		// to something usable.
		// the `import` clause makes the method `to_cstring` available in C.
		char *str = String_to_cstring(self);

		// In Nit, `to_cstring` returns a `NativeString`.
		// In C, `NativeString` are automatically converted to `char*`.
		char *res = strchr(str, c);
		if (res==NULL) return -1;
		return res - str;
	`}
end

print "Hello, World!".strchr('W')
print "Hello, World!".strchr('*')
