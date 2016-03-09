# Visitor Design Pattern

The well-known Visitor Design Pattern allow to dissociate the traversal of an heterogeneous , it thus allows to implement specific behavior and computation on such a tree without having to update or change the existing code.

The standard way is to engineer the visited classes with a spacial callback `accept` that will invoke a specific `visit_*` method in an abstract Visitor.
Adding a new behavior and computation is done in specific subclasses of the abstract visitor. 

This standard way has some issues:

* the visitor has to be developed with the data-classes
* the visitor is complex with a lot of methods
* the signature of the `visit_*` methods has to be decided once for all (there is various ways to mitigate the issue dependently on the language)
* there is a specific and independent method `visit_*` method for each concrete data-class, without a nice OO way to factorize them
* most of the implemented behavior is the sole responsibility of the data-class and implementing them in a concrete visitor is not optimal (bad responsibility assignment, bad coupling)

Concern-oriented programming and class refinement in Nit helps to solve most of these issues.

So, let the following classes used to represent a boolean expression.

~~~nit
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
~~~

Let's add a visitor, by refinement of the existing classes in a new and independent module.

~~~nit
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
~~~

You can see that the visitor can be created after the data-classes without altering the original module.

Let's now implement some visitor that count the number of binary operations in an expression.

~~~
module bool_count

import bool_visitor

class BoolCounter
	super Visitor

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

var ev = new BoolCounter
print ev.eval(e1) # write 2
print ev.eval(e2) # write 3
~~~


## Mission

Implement an evaluator that can visit and transform one of our Boolean expression to a standard Bool value `true` or `false`.

### Template to Use

~~~nit
module bool_eval

import bool_visitor

# CODE HERE

var e1 = new BoolOr(new BoolAnd(new BoolTrue, new BoolFalse), new BoolNot(new BoolTrue))
var e2 = new BoolAnd(new BoolNot(e1), new BoolTrue)

print e1.eval
print e2.eval
~~~

### Expected Output

~~~
false
true
~~~
