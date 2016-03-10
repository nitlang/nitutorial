# Functions

Functions start with the `fun` keyword. Require a name, parameters (if any) and a return type (if any).

~~~nit
fun presentation(name: String, age: Int): String
do
	return "Hello, my name is {name} and I am {age}. I live in the Dome and I am an happy Citizen."
end

print presentation("Alice", 21)
~~~

## Default Argument Values

Default arguments value rely on the `nullable` information: trailing null in a call can be omitted.

~~~
fun presentation(name: nullable String, age: nullable Int): String
do
	if name == null then name = "Anonymous"
	# Note: Adaptive typing says that `name` is a non-nullable here
	var res = "Hello, my name is {name}"
	if age != null then
		# Note: Adaptive typing says that `age` is a non-nullable here
		# type adaptation
		res += " and I am {age}"
	end
	res += ". I live in the Dome and I am an happy Citizen."
	return res
end
print presentation("Alice", 21)
print presentation("Bob")
print presentation(null, 99)
print presentation
~~~

## Variadic Function

A parameter can old a variable number of arguments, its type has to be be suffixed by the ellipsis `...`

On the call side, 1 or more parameter can be given, on the method side, the static type of the parameter is an Array.

~~~
fun present_all(names: String...): String
do
	if names.length == 1 then
		return presentation(names.first)
	else
		return "Hello, we are {names.join(", ")} and we are legion."
	end
end
print present_all("Alice", "Bob", "Dylan")
print present_all("Eve")
~~~


## Mission

* Difficulty: tutorial

Write a function `hanoi` that plays the Towers of Hanoi.

### Template to Use

~~~nit
module hanoi

# CODE HERE

print "Test 3 disks"
hanoi(3)

print "Test 5 disks"
hanoi(5)
~~~

### Expected Result

~~~
Test 3 disks
Move disk from 0 to 1.
Move disk from 0 to 2.
Move disk from 1 to 2.
Move disk from 0 to 1.
Move disk from 2 to 0.
Move disk from 2 to 1.
Move disk from 0 to 1.
Test 5 disks
Move disk from 0 to 1.
Move disk from 0 to 2.
Move disk from 1 to 2.
Move disk from 0 to 1.
Move disk from 2 to 0.
Move disk from 2 to 1.
Move disk from 0 to 1.
Move disk from 0 to 2.
Move disk from 1 to 2.
Move disk from 1 to 0.
Move disk from 2 to 0.
Move disk from 1 to 2.
Move disk from 0 to 1.
Move disk from 0 to 2.
Move disk from 1 to 2.
Move disk from 0 to 1.
Move disk from 2 to 0.
Move disk from 2 to 1.
Move disk from 0 to 1.
Move disk from 2 to 0.
Move disk from 1 to 2.
Move disk from 1 to 0.
Move disk from 2 to 0.
Move disk from 2 to 1.
Move disk from 0 to 1.
Move disk from 0 to 2.
Move disk from 1 to 2.
Move disk from 0 to 1.
Move disk from 2 to 0.
Move disk from 2 to 1.
Move disk from 0 to 1.
~~~
