# Collection and for loops


In Nit there is various kind of collections.
They are used to manipulate finite groups of objects.

Because Nit is statically types, the type of the elements of a collection is available.

The most common collection is `Array`.

~~~nit
var a = [2, 3, 5]
print a.length # 3
print a.first # 2
print a[2] # 5
~~~

Array is a mutable data-structure and elements can be added of removed.

~~~nit
print a.pop # 5
print a     # [2,3]
a.add 50
print a     # [2,3,50]
~~~

Another useful collection is Range. It is used to store intervals.

There is two kind of ranges, the closed ones and the semi-open one (we just say open even if it is not mathematically accurate).

~~~nit
var closed = [10..15]
print closed # [10,11,12,13,14,15]
var open = [10..15[
print open # [10,11,12,13,14]
~~~


The most common operation on range is to iterate on them.
The `for` control structure just do that.

~~~nit
for i in [0..5[ do print i # 0 1 2 3 4
~~~


## Mission

* Difficulty: tutorial


Write a function that outputs the numbers of a collection that are odd and lower than 42.

~~~nit
fun filter(ints: Collection[Int])
do
# Your code here
end

print "Test 1"
filter([1,2,3,41,42,43,9])
print "Test 2"
filter([35..45])
~~~

Expected output

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
