module filter

fun filter(ints: Collection[Int])
do
	for i in ints do if i.is_odd and i < 42 then print i
end

print "Test 1"
filter([1,2,3,41,42,43,9])
print "Test 2"
filter([35..45])
