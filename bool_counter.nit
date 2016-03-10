module bool_counter

import bool_visitor

class BoolCounter
	super BoolVisitor

	fun count(expr: BoolExpr): Int
	do
		cpt = 0
		visit(expr)
		return cpt
	end

	redef fun visit(expr) do
		# Call the specific count code
		expr.accept_count(self)
		# Recursively process the sub-expressions if any
		expr.visit_children(self)
	end

	# Counter of binary operations
	var cpt = 0
end

redef class BoolExpr
	# The specific `counting` behavior.
	private fun accept_count(v: BoolCounter) do end
end

redef class BoolBinOp
	redef fun accept_count(v) do v.cpt += 1
end

var e1 = new BoolOr(new BoolAnd(new BoolTrue, new BoolFalse), new BoolNot(new BoolTrue))
var e2 = new BoolAnd(new BoolNot(e1), new BoolTrue)

var v = new BoolCounter
print v.count(e1) # 2
print v.count(e2) # 3
