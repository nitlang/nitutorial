module hanoi

fun hanoi(n: Int, s, t, u: nullable Int)
do
	s = s or else 0
	t = t or else 1
	u = u or else 2

	if n == 1 then
		print "Move disk from {s} to {t}."
	else
		hanoi(n-1, s, u, t)
		hanoi(1,   s, t, u)
		hanoi(n-1, u, t, s)
	end
end

print "Test 3 disks"
hanoi(3)

print "Test 5 disks"
hanoi(5)
