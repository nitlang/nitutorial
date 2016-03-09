# Visit the simple Boolean expressions
module bool_visitor

import bool_expr

# An abstract visitor.
#
# Please implement `visit` for specific behavior and computation.
abstract class BoolVisitor
	# Visit an
	fun visit(expr: BoolExpr) is abstract
end

redef class BoolExpr
	# Call `visit` in order on each sub-expressions (if any)
	fun visit_children(v: BoolVisitor) do end
end

redef class BoolBinOp
	redef fun visit_children(v)
	do
		v.visit(left)
		v.visit(right)
	end
end

redef class BoolNot
	redef fun visit_children(v)
	do
		v.visit(expr)
	end
end
