# Control Structures and conditions

Usual control structure, like condition and loops, are available.

Most of them exists in two flavor: one-liner and multi-line.

The one-liner flavor needs a single statement just after the control.

~~~nit
if a > 9000 then print "It's over 9000!!!"
~~~

The multi-line flavor have a line-return after the control but require a `end` keyword.

~~~nit
if a > 9000 then
	print "It's over 9000!!!"
	print "What?! Nine thousand?!"
end
~~~


The `if` control accepts `else` block.

~~~nit
if a > 9000 then
	print "It's over 9000!!!"
else if a > 1000 then
	print "It's over 1000..."
else
	print "It's not impressive."
end
~~~


`while` loops are also available:

~~~nit
var i = 999
while i > 1 do
	print "{i} bottles on the wall..."
	i -= 1
end
print "1 last bottle on the wall..."
~~~

`for` is an improved `while` that iterates on collections.
They will be shown in a latter mission, for the moment, we will use them to iterate on ranges of integers.

~~~nit
for i in [0..5[ do print i ; 0 1 2 3 4 (5 is excluded)
~~~

## Mission

* Difficulty: easy

White a loop that computes the first Fibonacci number above a given limit. 

Confidential information: fib(0) = 0; fib(1) = 1; fib(n) = fib(n-1) + fib(n-2)

### Template to Use

~~~nit
var limit = 500

var prev = 0
var n = 1

# CODE HERE

print "The first Fibonacci number > {limit} is {n}."
~~~

### Expected output

~~~
The first Fibonacci number > 500 is 610.
~~~
