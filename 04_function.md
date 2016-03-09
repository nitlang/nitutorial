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
fun presentation(name: String, age: nullable Int): String
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
fun present_all(names: String...)
do
	if names.length == 1 then
		presentation(names.first)
	else
		print "Hello, we are {names.join(", ")} and we are legion."
	end
end
print presentation("Alice", "Bob", "Dylan")
~~~


## Mission

* Difficulty: tutorial

### Template to Use



~~~nit
module function

# CODE HERE


~~~

### Expected Result
