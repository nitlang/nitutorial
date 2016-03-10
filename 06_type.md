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

<pre class="hl"><span class="hl kwa">var</span> a<span class="hl opt">:</span> <span class="hl kwb">Int</span> <span class="hl opt">=</span> <span class="hl num">10</span>            <span class="hl slc"># OK</span>
<span class="hl kwa">var</span> b<span class="hl opt">:</span> <span class="hl kwa">nullable</span> <span class="hl kwb">Int</span> <span class="hl opt">=</span> <span class="hl num">1</span>    <span class="hl slc"># OK</span>
<span class="hl kwa">var</span> c<span class="hl opt">:</span> <span class="hl kwa">nullable</span> <span class="hl kwb">Int</span> <span class="hl opt">=</span> <span class="hl kwa">null</span> <span class="hl slc"># OK</span>
<span class="hl kwa">var</span> d<span class="hl opt">:</span> <span class="hl kwb">Int</span> <span class="hl opt">=</span> <span class="hl kwa">null</span> <span class="hl slc"># NOT OK</span>
<span class="hl slc">#            ^</span>
<span class="hl slc"># Type Error: expected `Int`, got `null`.</span>
</pre>

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

<pre class="hl"><span class="hl slc"># Double a number; if null is given 0 is returned.</span>
<span class="hl kwa">fun</span> double<span class="hl opt">(</span>value<span class="hl opt">:</span> <span class="hl kwa">nullable</span> <span class="hl kwb">Int</span><span class="hl opt">):</span> <span class="hl kwb">Int</span>
<span class="hl kwa">do</span>
	<span class="hl slc"># Here, `value` is a `nullable Int`</span>
	<span class="hl kwa">if</span> value <span class="hl opt">==</span> <span class="hl kwa">null then return</span> <span class="hl num">0</span>
	<span class="hl slc"># Here, `value` is a `Int`. It's *adaptive typing!</span>
	<span class="hl kwa">return</span> value <span class="hl opt">*</span> <span class="hl num">2</span>
<span class="hl kwa">end</span>
print double<span class="hl opt">(</span><span class="hl kwa">null</span><span class="hl opt">)</span>
print double<span class="hl opt">(</span><span class="hl num">10</span><span class="hl opt">)</span>
</pre>

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

<pre class="hl"><span class="hl kwa">fun</span> triple<span class="hl opt">(</span>value<span class="hl opt">:</span> <span class="hl kwa">nullable</span> <span class="hl kwb">Int</span><span class="hl opt">):</span> <span class="hl kwb">Int</span>
<span class="hl kwa">do</span>
	<span class="hl slc"># Here `value` is a `nullable Int`</span>
	<span class="hl kwa">if</span> value <span class="hl opt">==</span> <span class="hl kwa">null then</span>
		<span class="hl slc"># Here `value` is `null`</span>
		value <span class="hl opt">=</span> <span class="hl num">0</span>
		<span class="hl slc"># Here `value` is `Int`</span>
	<span class="hl kwa">end</span> <span class="hl slc"># In the implicit and empty else, `value` is `Int`</span>
	<span class="hl slc"># Here `value` is Int</span>
	<span class="hl kwa">return</span> value <span class="hl opt">*</span> <span class="hl num">3</span>
<span class="hl kwa">end</span>
print triple<span class="hl opt">(</span><span class="hl kwa">null</span><span class="hl opt">)</span>
print triple<span class="hl opt">(</span><span class="hl num">10</span><span class="hl opt">)</span>
</pre>

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

<pre class="hl"><span class="hl kwa">fun</span> what_it_is<span class="hl opt">(</span>value<span class="hl opt">:</span> <span class="hl kwa">nullable</span> <span class="hl kwb">Object</span><span class="hl opt">)</span>
<span class="hl kwa">do</span>
	<span class="hl slc"># `value` is a `nullable Object` that is the most general type is the type hierarchy of Nit.</span>
	<span class="hl kwa">if</span> value <span class="hl opt">==</span> <span class="hl kwa">null then</span>
		print <span class="hl str">&quot;It's null&quot;</span>
		<span class="hl kwa">return</span>
	<span class="hl kwa">end</span>
	<span class="hl slc"># Now, `value` is a `Object` that is the root of the class hierarchy.</span>
	<span class="hl kwa">if</span> value <span class="hl kwa">isa</span> <span class="hl kwb">Int</span> <span class="hl kwa">then</span>
		<span class="hl slc"># Now `value` is a `Int`.</span>
		<span class="hl slc"># No need to cast, the static type is already adapted.</span>
		print <span class="hl str">&quot;It's the integer</span> <span class="hl esc">{value}</span><span class="hl str">, the one that follows</span> <span class="hl esc">{value-1}</span><span class="hl str">.&quot;</span>
		<span class="hl slc"># Because `value` is an `Int`, `value-1` is accepted</span>
	<span class="hl kwa">else if</span> value <span class="hl kwa">isa</span> <span class="hl kwb">String</span> <span class="hl kwa">then</span>
		print <span class="hl str">&quot;It's the string `</span><span class="hl esc">{value}</span><span class="hl str">`, made of</span> <span class="hl esc">{value.length}</span> <span class="hl str">charcters.&quot;</span>
	<span class="hl kwa">else</span>
		print <span class="hl str">&quot;Whathever it is, I do not care.&quot;</span>
	<span class="hl kwa">end</span>
<span class="hl kwa">end</span>
what_it_is <span class="hl num">5</span>
what_it_is <span class="hl str">&quot;five&quot;</span>
what_it_is <span class="hl kwa">true</span>
</pre>

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

<pre class="hl"><span class="hl kwa">module</span> deep_first

<span class="hl kwa">fun</span> deep_first<span class="hl opt">(</span>a<span class="hl opt">:</span> <span class="hl kwb">Object</span><span class="hl opt">):</span> <span class="hl kwb">Object</span>
<span class="hl kwa">do</span>
	<span class="hl slc"># CHANGE BELOW</span>
	<span class="hl opt">...</span> a <span class="hl kwa">isa</span> <span class="hl kwb">Collection</span><span class="hl opt">[</span><span class="hl kwb">Object</span><span class="hl opt">] ...</span>
	<span class="hl slc"># CHANGE ABOVE</span>
<span class="hl kwa">end</span>

<span class="hl kwa">var</span> one <span class="hl opt">=</span> <span class="hl num">1</span>
print deep_first<span class="hl opt">(</span>one<span class="hl opt">)</span>
<span class="hl kwa">var</span> range <span class="hl opt">= [</span><span class="hl num">1</span><span class="hl opt">.</span><span class="hl num">.5</span><span class="hl opt">]</span>
print deep_first<span class="hl opt">(</span>range<span class="hl opt">)</span>
<span class="hl kwa">var</span> ranges <span class="hl opt">= [</span>range<span class="hl opt">, [</span><span class="hl num">3</span><span class="hl opt">.</span><span class="hl num">.8</span><span class="hl opt">]]</span>
print deep_first<span class="hl opt">(</span>ranges<span class="hl opt">)</span>
<span class="hl kwa">var</span> arrays <span class="hl opt">= [[</span><span class="hl num">2</span><span class="hl opt">,</span><span class="hl num">3</span><span class="hl opt">],[</span><span class="hl num">3</span><span class="hl opt">,</span><span class="hl num">4</span><span class="hl opt">]]</span>
print deep_first<span class="hl opt">(</span>arrays<span class="hl opt">)</span>
</pre>

### Expected Outputs

~~~
1
1
1
2
~~~
