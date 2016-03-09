import bool_visitor

redef class BoolExpr
	fun eval: Bool is abstract
end

redef class BoolAnd
	redef fun eval do return left.eval and right.eval
end

redef class BoolOr
	redef fun eval do return left.eval or right.eval
end

redef class BoolNot
	redef fun eval do return not expr.eval
end

redef class BoolTrue
	redef fun eval do return true
end

redef class BoolFalse
	redef fun eval do return false
end

var e1 = new BoolOr(new BoolAnd(new BoolTrue, new BoolFalse), new BoolNot(new BoolTrue))
var e2 = new BoolAnd(new BoolNot(e1), new BoolTrue)

print e1.eval
print e2.eval
