# Foreign Function Interface

The Nit Foreign Function Interface (FFI) allows to nest code within a Nit source file.
Current supported languages are C, C++, Java (used maily for android) and Objective C (used mainly for iOS).

Common use cases of the FFI is to optimize a method or wrap existing system or third-party libraries.
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

Nit FFI is the easiest way to wrap libraries and extern code in Nit.

Advanced features include:

* inclusion of global declrtation
* automatic conversion  some Nit and native types
* declaration of callback function to call nit method from within the native code.

The following examble show how we can ust the C function `strchr` to search a character in a string.

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


## Mission

Write a simple wrapper around [libcaca](http://caca.zoy.org/doxygen/libcaca/caca_8h.html) so that the follwing client behave correctly.

~~~nit

~~~
