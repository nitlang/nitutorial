# Nullable and Adaptive Typing

One of the specific feature of Nit the management of the `null` value and how the static types of expressions and variable are computed.

Unlike most other language, the `null` value is statically controlled, therefore it cannot occurs randomly.

To accept `null`, the static type must be extended with the `nullable` keyword.

~~~nit
var a: Int = 10            # OK
var b: nullable Int = 1    # OK
var c: nullable Int = null # OK
var d: Int = null # NOT OK
#            ^
# Type Error: expected `Int`, got `null`.
~~~

The static type system controls that `null` does not propagate to unwanted places.
Therefore, it is required to test the value of expressions that might be null.

To control the correction of programs, the static type system of Nit features *adaptive typing*.
Adaptive typing is used to track the static types of variables and expressions.
With adaptive typing, the static type of variables might changes according to:

* its assignments
* its comparisons to null (with `==` and `!=`)
* its type checks (with `isa` seen bellow)
* the control flow of the program (`if`, `while`, `break`, `and`, etc.)

~~~nit
# Double a number; if null is given 0 is returned.
fun double(value: nullable Int): Int
do
	# Here, `value` is a `nullable Int`
	if value == null then return 0
	# Here, `value` is a `Int`. It's *adaptive typing*!
	return value * 2
end
print double(null)
print double(10)
~~~

Adaptive typing correctly handle independent assignments.

~~~nit
fun triple(value: nullable Int): Int
do
	# Here `value` is a `nullable Int`
	if value == null then
		# Here `value` is `null`
		value = 0
		# Here `value` is `Int`
	end # In the implicit and empty else, `value` is `Int`
	# Here `value` is Int
	return value * 3
end
print triple(null)
print triple(10)
~~~


The `isa` keyword can be used to test the dynamic type of an expression.
If the expression is a variable, then its static type can be adapted.

~~~nit
fun what_it_is(value: nullable Object)
do
	# `value` is a `nullable Object` that is the most general type is the type hierarchy of Nit.
	if value == null then
		print "It's null!"
		return
	end
	# Now, `value` is a `Object` that is the root of the class hierarchy.
	if value isa Int then
		# Now `value` is a `Int`.
		# No need to cast, the static type is already adapted.
		print "It's the integer {value}, the one that follows {value-1}."
		# Because `value` is an `Int`, `value-1` is accepted
	else if value isa String then
		print "It's the string `{value}`, made of {value.length} charcters."
	else
		print "Whathever it is, I do not care."
	end
end
what_it_is 5
what_it_is "five"
what_it_is true
~~~

## Mission

Implements a method `deep_first` that returns the first non-collection element of an object.

### Template to Use

~~~nit
module deep_first

fun deep_first(a: Object): Object
do
	# CHANGE BELOW
	... a isa Collection[Object] ...
	# CHANGE ABOVE
end

var one = 1
print deep_first(one)
var range = [1..5]
print deep_first(range)
var ranges = [range, [3..8]]
print deep_first(ranges)
var arrays = [[2,3],[3,4]]
print deep_first(arrays)
~~~

### Expected Outputs

~~~
1
1
1
2
~~~
