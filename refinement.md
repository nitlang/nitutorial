# Class Refinement

One of the best feature of Nit is refinement.

Refinement is modifying an existing methods and classes in a statistically and controlled way:

* New methods
* New attributes
* Override methods
* New super-classes

The keyword `redef` is used to declare that a class definition is a refinement.

~~~nit
# Improve the class Int with a recursive Fibonacci function.
redef class Int
   fun fib: Int do
      if self <= 2 then return self
      return (self - 1).fib + (self - 2).fib
   end
end

print 6.fib # 8
~~~

Refinement is

* Aspect-Oriented Programming,

  but without weaving issues.

* Monkey-patching,

  but statically checked.


In a refinement of a method, the previous definition is accessible with the `super` keyword.
This allows refiners to add additional behavior before and/or after the original behavior, or to change it completely.

For instance, the core method `run` is the one that control the main execution of a program.
It is often refined to add additional behavior before and after the main program. 

As with classes, the keyword `redef`

~~~nit
redef fun run
do
	print "Start program"
	super
	print "End program"
end

print "Hello, World!"
~~~

Will output

~~~
Start program
Hello, World!
End program
~~~


By default `super` will reuse all the original parameters, you can provide new one anyway.
The types of the parameters and the return type are 

~~~nit
redef fun print(value)
do
	super "The Emperor says ``{value}''."
end

print "Hello, World!"
~~~

## Mission

* Difficulty: easy

In order to encrypt future communication, refine the `print` method to print anything in ROT13.

Hint1: do not infinitely recurse

Hint2: the module `crypto` provide a `rot(13)` method that can be applied on strings.

~~~nit
import crypto

redef fun print(value)
do
	var text = value.to_s
	# CODE HERE
end

print "Hello, World!"
print "Goodbye, World!"
~~~

### Expected Output

~~~
Uryyb, Jbeyq!
Tbbqolr, Jbeyq!
~~~
