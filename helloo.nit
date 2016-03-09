module helloo

class Hello
	var what: String
	fun say do print "Hello, {what}!"
end

class Goodbye
	var hello: Hello
	fun say do print "Goodbye, {hello.what}!"
end

var h = new Hello("World")
h.say
var g = new Goodbye(h)
g.say
