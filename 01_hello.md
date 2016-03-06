# Hello, World!

We found an ancient language called Nit. Historian say that if was the most popular language of the pre-alpha era.
A lot of dome life systems and security protocol are based on Nit. This may be our chance!
We need you to master this language!

According to apocryphal documentation, Nit is a statically typed language that aims at elegance, simplicity and intuitiveness.  

For instance, `print` is a function that print something at the screen

~~~nit
print "I print therefore I am."
~~~

In fact, `print` is a method from the core library that accepts any kind of objects and prints a human-readable form to standard output; but these concept will be introduced latter.

Nit can be both compiled (with `nitc`) or interpreted (with `nit`).
Moreover, if the source code has the right permissions and starts with `#!/usr/bin/env nit`, it can be executed directly.

~~~
$ cat rene.nit
#!/usri/bin/env nit
print "I print therefore I am."
$ nitc rene.nit
$ ./rene
I print therefore I am.
$ nit rene.nit
I print therefore I am.
$ chmod +x rene.nit
$ ./rene.nit
I print therefore I am.
~~~


## Mission

* Difficulty: tutorial

To prove your achievement, send us a program that output the traditional *Hello, World!*
A template is provided bellow.

~~~nit
# CHANGE BELLOW
print "Something, Something!"
# CHANGE ABOVE
~~~

Expected output

~~~
Hello, World!
~~~
