# Modules

Nit source files are called *modules*.
A module can define classes and methods, can import classes and method of imported modules and can refine them.

The keyword `module` can be used to declare a module. It is optional but when given, the module name must match the filename.
The `module` declaration is also used to attach the documentation and to attach specific module annotations.

The keyword `import` is used to import other modules.

~~~
# Simple program that says hello
module hello
print "Hello, World!"
~~~

~~~
# I don't know why you say hello, I say goodbye
module goodbye
import hello

super # Call the previous `main`
print "Goodbye, World!"
~~~

Nit promotes Concern-Oriented Development where each module ideally operates on a single concern.
A Nit program is just a module that imports all the required concerns.

Moreover, importation of modules can be done and configured at link-time (with `-m` and `-D`) to generate specific configurations of a product line.

~~~nit
module pire
fun ctator: String do return "The Emperor says"
redef fun print(value) do super "{ctator} ``{value}''"
~~~

~~~sh
$ nitc goodbye.nit
$ ./goodbye
Hello, World!
Goodbye, World!
$ nitc goodbye.nit -m pire.nit # -m means mixin (or module; think what you want, I'm just a comment)
$ ./goodbye
The Emperor says ``Hello, World!''
The Emperor says ``Goodbye, World!''
$ nitc goodbye.nit -m pire.nit -D ctator="The Rebels say" # -D means define
$ ./goodbye
The Rebels say ``Hello, World!''
The Rebels say ``Goodbye, World!''
~~~

## Mission

* Difficulty: medium

Hera a programm that prints the command line arguments separated by a comma.

~~~
print args.join(", ")
~~~

You mission it to write a mixin module that will change the behavior of this program so it prints "`Y0u, 4r3, H4cK3d`" instead.

~~~
module hacker
# CODE HERE
~~~

