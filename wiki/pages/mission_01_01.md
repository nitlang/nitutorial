# Hello, World!

We found an ancient language called Nit. Historians say that it was the most popular language of the pre-alpha era.
A lot of Dome life systems and security protocols are based on Nit. This may be our chance!
We need you to master this language!

According to apocryphal documentation, Nit is a statically typed language that aims at elegance, simplicity and intuitiveness.

For instance, `print` is a function that print something at the screen.

<pre class="hl">print <span class="hl str">&quot;I print therefore I am.&quot;</span>
</pre>


In fact, `print` is a method from the core library that accepts any kind of objects and prints a human-readable form to standard output; but these concepts will be introduced later.

Nit can be both compiled (with `nitc`) or interpreted (with `nit`).
Moreover, if the source code has the right permissions and starts with `#!/usr/bin/env nit`, it can be executed directly.

	$ cat rene.nit
	#!/usr/bin/env nit
	print "I print therefore I am."

	$ nitc rene.nit
	$ ./rene
	I print therefore I am.

	$ nit rene.nit
	I print therefore I am.

	$ chmod +x rene.nit
	$ ./rene.nit
	I print therefore I am.

## Mission

* Difficulty: tutorial

To prove your achievement, send us a program that outputs the traditional *Hello, World!*

For all the missions in this track, you must submit your Nit source code on [http://nit.csgames.org:8090/](http://nit.csgames.org:8090/).

### Template to Use

For each mission, a template is provided.

* You must use it.
* You can only write your code in the specified places
* You cannot modify other parts.

The template of the mission is the following one:

<pre class="hl"><span class="hl kwa">module</span> hello
<span class="hl slc"># CHANGE BELOW</span>
print <span class="hl str">&quot;Something, Something&quot;</span>
<span class="hl slc"># CHANGE ABOVE</span>
</pre>

### Expected Output

	Hello, World!
