module fibonacci

var limit = 500

var prev = 0
var n = 1

while n <= limit do
	var tmp = n
	n = n + prev
	prev = tmp
end

print "The first Fibonacci number > {limit} is {n}."
