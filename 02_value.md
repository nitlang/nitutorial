# Values and Types

Nit is a full Object-Oriented, it means that any value manipulated is an object (even primitive value like integers). Nit is also Class-Oriented, it means that any object is the instance of a class.

Nit is also fully statically typed.
It means that any expression, local variable, parameter, returns value and attributes of instance has a static type that documents and controls what kind of values are expected.

Local variables are used to hold values.
To use variable you must declare them (with the `var` keyword).
You can assign them (with `=`) and use them in expression.

~~~nit
var i
i = 5
print i + 1 # Outputs 6
~~~

As you can see, even if Nit is statically typed, the language does not force the programmer to annotate most static types.
The static type system automatically associate `i` with the the static type `Int`, the static type is then used to check that `+ 1` is legal on `i`.

For instance, the type system will prevent a tired programmer to add Booleans:

~~~nit
var j = true
print j + 1
#       ^
# Compilation Error: Error: method `+` does not exists in `Bool`.
~~~

Beside integers (`Int`) and Booleans (`Bool`), the core library defines a lot of other classes like `String` and `Float`.

Static types are mainly used to ensure that the operations used on the values are legal for any execution of the libraries or the program.

Common operations are available on the types defined by the core library. For instance:

~~~nit
var three = 1 + 2
var hw = "hello" + " " + "world"
~~~

The type system ensures that operations are valid on the operands.
For instance mixing types does not always work:

~~~nit
print three + hw
#             ^
# Type Error: expected `Int`, got `String`
~~~


Conversion between type can be achieved with special operations like `to_i`, `to_s`.

Moreover, string expansion is available through the `{}` notation:

~~~nit
print "one plus one is {1+1}" # one plus one is 2
print "10".to_i + 10 # 20
print 10.to_s + "10" # 1010
~~~

Inside strings, `"` and `{` can be escaped with `\`. Or a triple quoted notation could be used.

~~~nit
print "\"quote\" and \{curly brackets\}"
print """"quote" and {curly brackets}"""
~~~

## Mission

* Difficulty: tutorial

Define two variables, `a_string` and `an_integer` initialized respectively to `"ten"` and `10`.

~~~nit
# CHANGE BELLOW
var a_string = ?
var an_integer = ?
# CHANGE ABOVE

print "a_string! {a_string + "!"}"
print "an_integer! {an_integer.factorial}"
~~~

### Expected Output

~~~
a_string! ten!
an_integer! 3628800
~~~
