# Foreign Function Interface

The Nit Foreign Function Interface (FFI) allows to nest foreign code within a Nit source file.
Current supported languages are C, C++, Java (used mainly for android support) and Objective C (used mainly for iOS support).

Common use cases of the FFI is to optimize a method or to wrap existing system or third-party libraries.
The syntax use back-quoted curly-brackets.

~~~nit
fun in_nit do print "In Nit"
fun in_c `{ printf("In C\n"); `}
fun in_cpp in "C++" `{ cout << "In C++" << endl; `}
fun in_java in "Java" `{ System.out.println("In Java"); `}
fun in_objc in "ObjC" `{ NSLog (@"In Objective C\n"); `}

in_nit
in_c
in_cpp
in_java
in_objc
~~~

Advanced features of the Nit FFI include:

* inclusion of global declarations
* automatic conversion between some Nit and foreign types
* declaration of callback functions to call Nit method from within the foreign code.

The following example shows how can the C function `strchr` be used to search a character in a string.

~~~nit
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
~~~

## Mission

Refine the class `String` and add a method `fnmatch(pattern: String): Bool` that wrap the POSIX function `fnmatch` (Hint: `man fnmatch`)

### Template to Use

~~~
# CODE HERE

print "mpire.nit".fnmatch("*.nit")
print "mpire.nit".fnmatch("*.zip")
~~~

### Expected Output

~~~
true
false
~~~
