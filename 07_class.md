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

<pre class="hl"><span class="hl kwa">class</span> <span class="hl kwb">Movie</span>
	<span class="hl kwa">fun</span> is_about_cyclign<span class="hl opt">:</span> <span class="hl kwb">Bool</span> <span class="hl kwa">do return true</span>
<span class="hl kwa">end</span>

<span class="hl kwa">class</span> <span class="hl kwb">Americaine</span>
	<span class="hl kwa">super</span> <span class="hl kwb">Movie</span>
	<span class="hl kwa">redef fun</span> is_about_cyclign <span class="hl kwa">do return false</span>
<span class="hl kwa">end</span>

<span class="hl kwa">var</span> f <span class="hl opt">=</span> <span class="hl kwa">new</span> <span class="hl kwb">Movie</span>
print f<span class="hl opt">.</span>is_about_cyclign <span class="hl slc"># true</span>
f <span class="hl opt">=</span> <span class="hl kwa">new</span> <span class="hl kwb">Americaine</span>
print f<span class="hl opt">.</span>is_about_cyclign <span class="hl slc"># false</span>
</pre>

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
var i = new Inventory(1, "stone")
# initialize `an_int` and `a_string` and call `init`.
So print "1 stone, 2 houses..."
~~~

<pre class="hl"><span class="hl kwa">class</span> <span class="hl kwb">Inventory</span> <span class="hl slc"># à la Pr�vert</span>
	<span class="hl kwa">var</span> an_int<span class="hl opt">:</span> <span class="hl kwb">Int</span>
	<span class="hl kwa">var</span> a_string<span class="hl opt">:</span> <span class="hl kwb">String</span>
	<span class="hl kwa">var</span> another_int <span class="hl opt">=</span> <span class="hl num">2</span>
	<span class="hl kwa">var</span> another_string <span class="hl opt">=</span> <span class="hl str">&quot;houses&quot;</span>
	<span class="hl kwa">init do</span> print <span class="hl str">&quot;</span><span class="hl esc">{an_int} {a_string}</span><span class="hl str">,</span> <span class="hl esc">{another_int} {another_string}</span><span class="hl str">...&quot;</span>
<span class="hl kwa">end</span>
<span class="hl kwa">var</span> i <span class="hl opt">=</span> <span class="hl kwa">new</span> <span class="hl kwb">Inventory</span><span class="hl opt">(</span><span class="hl num">1</span><span class="hl opt">,</span> <span class="hl str">&quot;stone&quot;</span><span class="hl opt">)</span>
<span class="hl slc"># initialize `an_int` and `a_string` and call `init`.</span>
<span class="hl kwb">So</span> print <span class="hl str">&quot;1 stone, 2 houses...&quot;</span>
</pre>p

Subclasses inherit the attributes and the constructor behavior and `init` are automatically linked (in fact there is an implicit `super`).

~~~nit
class MoreInventory
	super Inventory
	var a_3rd_int: Int
	var a_3rd_string: String
	init do print "{a_3rd_int} {a_3rd_string}..."
end
var j = new MoreInventory(1, "garden", 6, "musicians")
# print "1 garden, 2 houses..." and "6 musicians..."
~~~

<pre class="hl"><span class="hl kwa">class</span> <span class="hl kwb">MoreInventory</span>
	<span class="hl kwa">super</span> <span class="hl kwb">Inventory</span>
	<span class="hl kwa">var</span> a_3rd_int<span class="hl opt">:</span> <span class="hl kwb">Int</span>
	<span class="hl kwa">var</span> a_3rd_string<span class="hl opt">:</span> <span class="hl kwb">String</span>
	<span class="hl kwa">init do</span> print <span class="hl str">&quot;</span><span class="hl esc">{a_3rd_int} {a_3rd_string}</span><span class="hl str">...&quot;</span>
<span class="hl kwa">end</span>
<span class="hl kwa">var</span> j <span class="hl opt">=</span> <span class="hl kwa">new</span> <span class="hl kwb">MoreInventory</span><span class="hl opt">(</span><span class="hl num">1</span><span class="hl opt">,</span> <span class="hl str">&quot;garden&quot;</span><span class="hl opt">,</span> <span class="hl num">6</span><span class="hl opt">,</span> <span class="hl str">&quot;musicians&quot;</span><span class="hl opt">)</span>
<span class="hl slc"># print &quot;1 garden, 2 houses...&quot; and &quot;6 musicians...&quot;</span>
</pre>

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

<pre class="hl"><span class="hl kwa">module</span> helloo

<span class="hl slc"># CODE HERE</span>

<span class="hl kwa">var</span> h <span class="hl opt">=</span> <span class="hl kwa">new</span> <span class="hl kwb">Hello</span><span class="hl opt">(</span><span class="hl str">&quot;World&quot;</span><span class="hl opt">)</span>
h<span class="hl opt">.</span>say
<span class="hl kwa">var</span> g <span class="hl opt">=</span> <span class="hl kwa">new</span> <span class="hl kwb">Goodbye</span><span class="hl opt">(</span>h<span class="hl opt">)</span>
g<span class="hl opt">.</span>say
</pre>

### Expected Output

~~~
Hello, World!
Goodbye, World!
~~~
