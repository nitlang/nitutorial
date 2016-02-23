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


`break` and `continue` can be used to control the exit path from loops.


Two other special control structure are the `do` and the `loop`.
`do` is mainly used to scope local variables. It is also used to bound a `break`.

~~~nit
do
	if a > 9000 then break # exit the block
	print "It's over 9000!!!"
	if name != "Goku" then break # exit the block
	print "Big Bang Attack!"
end
~~~

`loop` is used as a infinite loop. It usually requires some additional explicit `break` to control the exit.
It is used to implement `do while/until` loops or `while` loops with a complex exit condition.

~~~nit
nb = 0
loop
	var line = gets
	if line == "" then break
	nb += 1
end
print "There was {nb} line(s)."
~~~



## Mission

* Difficulty: tutorial

White a loop that computes the first Fibonacci number above a given limit. 

Confidential information: fib(0) = 0; fib(1) = 1; fib(n) = fib(n-1) + fib(n-2)

~~~nit
var limit = 500

var prev = 0
var n = 1

# Code here

print "The first Fibonacci number > {limit} is {n}."
~~~

Expected output

~~~
The first Fibonacci number 500 is 610.
~~~
