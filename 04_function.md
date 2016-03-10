# Functions

Functions start with the `fun` keyword. Require a name, parameters (if any) and a return type (if any).

~~~nit
fun presentation(name: String, age: Int): String
do
	return "Hello, my name is {name} and I am {age}. I live in the Dome and I am an happy Citizen."
end

print presentation("Alice", 21)
~~~

<pre class="hl"><span class="hl kwa">fun</span> presentation<span class="hl opt">(</span>name<span class="hl opt">:</span> <span class="hl kwb">String</span><span class="hl opt">,</span> age<span class="hl opt">:</span> <span class="hl kwb">Int</span><span class="hl opt">):</span> <span class="hl kwb">String</span>
<span class="hl kwa">do</span>
	<span class="hl kwa">return</span> <span class="hl str">&quot;Hello, my name is</span> <span class="hl esc">{name}</span> <span class="hl str">and I am</span> <span class="hl esc">{age}</span><span class="hl str">. I live in the Dome and I am an happy Citizen.&quot;</span>
<span class="hl kwa">end</span>

print presentation<span class="hl opt">(</span><span class="hl str">&quot;Alice&quot;</span><span class="hl opt">,</span> <span class="hl num">21</span><span class="hl opt">)</span>
</pre>

## Default Argument Values

Default arguments value rely on the `nullable` information: trailing null in a call can be omitted.

~~~nit
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

<pre class="hl"><span class="hl kwa">fun</span> presentation<span class="hl opt">(</span>name<span class="hl opt">:</span> <span class="hl kwa">nullable</span> <span class="hl kwb">String</span><span class="hl opt">,</span> age<span class="hl opt">:</span> <span class="hl kwa">nullable</span> <span class="hl kwb">Int</span><span class="hl opt">):</span> <span class="hl kwb">String</span>
<span class="hl kwa">do</span>
	<span class="hl kwa">if</span> name <span class="hl opt">==</span> <span class="hl kwa">null then</span> name <span class="hl opt">=</span> <span class="hl str">&quot;Anonymous&quot;</span>
	<span class="hl slc"># Note: Adaptive typing says that `name` is a non-nullable here</span>
	<span class="hl kwa">var</span> res <span class="hl opt">=</span> <span class="hl str">&quot;Hello, my name is</span> <span class="hl esc">{name}</span><span class="hl str">&quot;</span>
	<span class="hl kwa">if</span> age <span class="hl opt">!=</span> <span class="hl kwa">null then</span>
		<span class="hl slc"># Note: Adaptive typing says that `age` is a non-nullable here</span>
		<span class="hl slc"># type adaptation</span>
		res <span class="hl opt">+=</span> <span class="hl str">&quot; and I am</span> <span class="hl esc">{age}</span><span class="hl str">&quot;</span>
	<span class="hl kwa">end</span>
	res <span class="hl opt">+=</span> <span class="hl str">&quot;. I live in the Dome and I am an happy Citizen.&quot;</span>
	<span class="hl kwa">return</span> res
<span class="hl kwa">end</span>
print presentation<span class="hl opt">(</span><span class="hl str">&quot;Alice&quot;</span><span class="hl opt">,</span> <span class="hl num">21</span><span class="hl opt">)</span>
print presentation<span class="hl opt">(</span><span class="hl str">&quot;Bob&quot;</span><span class="hl opt">)</span>
print presentation<span class="hl opt">(</span><span class="hl kwa">null</span><span class="hl opt">,</span> <span class="hl num">99</span><span class="hl opt">)</span>
print presentation
</pre>

## Variadic Function

A parameter can old a variable number of arguments, its type has to be be suffixed by the ellipsis `...`

On the call side, 1 or more parameter can be given, on the method side, the static type of the parameter is an Array.

~~~nit
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

<pre class="hl"><span class="hl kwa">fun</span> present_all<span class="hl opt">(</span>names<span class="hl opt">:</span> <span class="hl kwb">String</span><span class="hl opt">...):</span> <span class="hl kwb">String</span>
<span class="hl kwa">do</span>
	<span class="hl kwa">if</span> names<span class="hl opt">.</span>length <span class="hl opt">==</span> <span class="hl num">1</span> <span class="hl kwa">then</span>
		<span class="hl kwa">return</span> presentation<span class="hl opt">(</span>names<span class="hl opt">.</span>first<span class="hl opt">)</span>
	<span class="hl kwa">else</span>
		<span class="hl kwa">return</span> <span class="hl str">&quot;Hello, we are</span> <span class="hl esc">{names.join(&quot;, &quot;)}</span> <span class="hl str">and we are legion.&quot;</span>
	<span class="hl kwa">end</span>
<span class="hl kwa">end</span>
print present_all<span class="hl opt">(</span><span class="hl str">&quot;Alice&quot;</span><span class="hl opt">,</span> <span class="hl str">&quot;Bob&quot;</span><span class="hl opt">,</span> <span class="hl str">&quot;Dylan&quot;</span><span class="hl opt">)</span>
print present_all<span class="hl opt">(</span><span class="hl str">&quot;Eve&quot;</span><span class="hl opt">)</span>
</pre>

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

<pre class="hl"><span class="hl kwa">module</span> hanoi

<span class="hl slc"># CODE HERE</span>

print <span class="hl str">&quot;Test 3 disks&quot;</span>
hanoi<span class="hl opt">(</span><span class="hl num">3</span><span class="hl opt">)</span>

print <span class="hl str">&quot;Test 5 disks&quot;</span>
hanoi<span class="hl opt">(</span><span class="hl num">5</span><span class="hl opt">)</span>
</pre>

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
