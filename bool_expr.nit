# Simple Boolean expressions
module bool_expr

# A boolean expression
abstract class BoolExpr
end

# A boolean binary operation
abstract class BoolBinOp
	super BoolExpr
	# The left operand
	var left: BoolExpr
	# The right operand
	var right: BoolExpr
end

# A boolean conjunction
class BoolAnd
	super BoolBinOp
end

# A boolean disjunction
class BoolOr
	super BoolBinOp
end

# A boolean negation
class BoolNot
	super BoolExpr
	# the negated boolean
	var expr: BoolExpr
end

# A true boolean value
class BoolTrue
	super BoolExpr
end

# A false boolean value
class BoolFalse
	super BoolExpr
end
