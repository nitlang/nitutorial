# Collection and for loops

In Nit there is various kind of collections.
They are used to manipulate finite groups of objects.

Because Nit is statically typed, the type of the elements of a collection is statically known.

The most common collection is `Array`.

~~~nit
var a = [2, 3, 5]
print a.length # 3
print a.first # 2
print a[2] # 5
~~~

<pre class="hl"><span class="hl kwa">var</span> a <span class="hl opt">= [</span><span class="hl num">2</span><span class="hl opt">,</span> <span class="hl num">3</span><span class="hl opt">,</span> <span class="hl num">5</span><span class="hl opt">]</span>
print a<span class="hl opt">.</span>length <span class="hl slc"># 3</span>
print a<span class="hl opt">.</span>first <span class="hl slc"># 2</span>
print a<span class="hl opt">[</span><span class="hl num">2</span><span class="hl opt">]</span> <span class="hl slc"># 5</span>
</pre>

Array is a mutable data-structure and elements can be added of removed.

~~~nit
print a.pop # 5
print a     # [2,3]
a.add 50
print a     # [2,3,50]
~~~

<pre class="hl">print a<span class="hl opt">.</span>pop <span class="hl slc"># 5</span>
print a     <span class="hl slc"># [2,3]</span>
a<span class="hl opt">.</span>add <span class="hl num">50</span>
print a     <span class="hl slc"># [2,3,50]</span>
</pre>

Another useful collection is Range. It is used to store intervals.

There is two kind of ranges, the closed ones and the semi-open one (we just say open even if it is not mathematically accurate).

~~~nit
var closed = [10..15]
print closed # [10,11,12,13,14,15]
var open = [10..15[
print open # [10,11,12,13,14]
~~~

<pre class="hl"><span class="hl kwa">var</span> closed <span class="hl opt">= [</span><span class="hl num">10</span><span class="hl opt">.</span><span class="hl num">.15</span><span class="hl opt">]</span>
print closed <span class="hl slc"># [10,11,12,13,14,15]</span>
<span class="hl kwa">var</span> open <span class="hl opt">= [</span><span class="hl num">10</span><span class="hl opt">.</span><span class="hl num">.15</span><span class="hl opt">[</span>
print open <span class="hl slc"># [10,11,12,13,14]</span>
</pre>

The most common operation on collections is to iterate on them.
The `for` control structure just do that.

~~~nit
for i in [0..5[ do print i # 0 1 2 3 4
for i in [2, 3, 5] do print i # 2 3 5
~~~

<pre class="hl"><span class="hl kwa">for</span> i <span class="hl kwa">in</span> <span class="hl opt">[</span><span class="hl num">0</span><span class="hl opt">.</span><span class="hl num">.5</span><span class="hl opt">[</span> <span class="hl kwa">do</span> print i <span class="hl slc"># 0 1 2 3 4</span>
<span class="hl kwa">for</span> i <span class="hl kwa">in</span> <span class="hl opt">[</span><span class="hl num">2</span><span class="hl opt">,</span> <span class="hl num">3</span><span class="hl opt">,</span> <span class="hl num">5</span><span class="hl opt">]</span> <span class="hl kwa">do</span> print i <span class="hl slc"># 2 3 5</span>
</pre>

## Mission

* Difficulty: tutorial


Write a function that prints the numbers of a collection that are odd and lower than 42.

~~~nit
module filter

fun filter(ints: Collection[Int])
do
# CODE HERE
end

print "Test 1"
filter([1,2,3,41,42,43,9])
print "Test 2"
filter([35..45])
~~~

<pre class="hl"><span class="hl kwa">module</span> filter

<span class="hl kwa">fun</span> filter<span class="hl opt">(</span>ints<span class="hl opt">:</span> <span class="hl kwb">Collection</span><span class="hl opt">[</span><span class="hl kwb">Int</span><span class="hl opt">])</span>
<span class="hl kwa">do</span>
<span class="hl slc"># CODE HERE</span>
<span class="hl kwa">end</span>

print <span class="hl str">&quot;Test 1&quot;</span>
filter<span class="hl opt">([</span><span class="hl num">1</span><span class="hl opt">,</span><span class="hl num">2</span><span class="hl opt">,</span><span class="hl num">3</span><span class="hl opt">,</span><span class="hl num">41</span><span class="hl opt">,</span><span class="hl num">42</span><span class="hl opt">,</span><span class="hl num">43</span><span class="hl opt">,</span><span class="hl num">9</span><span class="hl opt">])</span>
print <span class="hl str">&quot;Test 2&quot;</span>
filter<span class="hl opt">([</span><span class="hl num">35</span><span class="hl opt">.</span><span class="hl num">.45</span><span class="hl opt">])</span>
</pre>

### Expected Output

~~~
Test 1
1
3
41
9
Test 2
35
37
39
41
~~~
