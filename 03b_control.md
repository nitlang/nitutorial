# Control of Control Structures

`break` and `continue` can be used to control the exit path from loops.

~~~nit
for i in [0..50[ do
	if i == 2 then continue
	if i == 5 then break
	print i
end
# output 0 1 3 4
~~~

Two other special control structure are the `do` and the `loop`.

`do` is mainly used to scope local variables. It is also used to bound a `break`.

~~~nit
do
	if level > 9000 then break # exit the block
	print "It's over 9000!!!"
	if not opponent.is_android then break # exit the block
	print "Big Bang Attack!"
end
~~~

`loop` is used as a infinite loop. It usually requires some additional explicit `break` to control the exit.
It is used to implement `do while/until` loops or `while` loops with a complex exit condition.

~~~nit
var nb = 0
loop
	var line = gets
	if line == "" then break
	nb += 1
end
print "There was {nb} line(s)."
~~~


## Mission

* Difficulty: easy

Finish the program that test the primality of some numbers.


~~~nit
module prime

var limit = 20

for i in [2..limit] do
	for j in [2..i[ do
		if i % j == 0 then
# CHANGE BELOW
...
print "{i} is not prime."
...
print "{i} is prime."
...
# CHANGE ABOVE
~~~

### Expected Output

~~~
2 is prime.
3 is prime.
4 is not prime.
5 is prime.
6 is not prime.
7 is prime.
8 is not prime.
9 is not prime.
10 is not prime.
11 is prime.
12 is not prime.
13 is prime.
14 is not prime.
15 is not prime.
16 is not prime.
17 is prime.
18 is not prime.
19 is prime.
20 is not prime.
~~~
