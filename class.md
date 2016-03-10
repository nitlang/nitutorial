# Classes and OOP

## Classes and Methods

Nit tries to be POLA in defining classes.

Classes are defined with the keyword `class`, super-classes are indicated with `super` (multiple inheritance is allowed), methods are introduced with `fun` and overridden with `redef fun`.
Instantiation is done with `new`.

~~~nit
class Movie
	fun is_about_cyclign: Bool do return true
end

class Americaine
	super Movie
	redef fun is_about_cyclign do return false
end

var f = new Movie
print f.is_about_cyclign # true
f = new Americaine
print f.is_about_cyclign # false
~~~

## Attributes and Constructors

Attributes (aka fields, slots or instance variables) are declared with `var`.
Their behavior differs slightly from most other languages and is strongly linked with how constructors are specified.

* no need to define accessors: attributes comes by default with a getter and a setter, the underling attribute is accessed internally.
* no need to define constructors: attributes without a default value need one when the object is allocated
* an optional parameter-less special method (declared with the keyword `init`) is called to finish the construction


~~~nit
class Inventory # à la Prévert
	var an_int: Int
	var a_string: String
	var another_int = 2
	var another_string = "houses"
	init do print "{an_int} {a_string}, {another_int} {another_string}..."
end
var i = new Inventory(1, "stone") # initialize `an_int` and `a_string` and call `init`. So print "1 stone, 2 houses..."
~~~

Subclasses inherit the attributes and the constructor behavior and `init` are automatically linked (in fact there is an implicit `super`).

~~~nit
class MoreInventory
	super Inventory
	var a_3rd_int: Int
	var a_3rd_string: String
	init do print "{a_3rd_int} {a_3rd_string}..."
end
var j = new MoreInventory(1, "garden", 6, "musicians") # print "1 garden, 2 houses..." and "6 musicians..."
~~~


## Mission

Write a class `Hello` with an attribute `what: String`, and a method `say: String` that prints `"Hello, {what}!"`.
Write a class `Goodby` with an attribute `hello: Hello`, and a method `say` that reply goodby.

### Template do Use

~~~nit
module helloo

# CODE HERE

var h = new Hello("World")
h.say
var g = new Goodbye(h)
g.say
~~~

### Expected Output

~~~
Hello, World!
Goodbye, World!
~~~
