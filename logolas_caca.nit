module logolas_caca

import logolas_parser
import logolas_lexer
import caca

class Interp
	super Visitor

	var x = 0
	var y = 0
	var angle = 0

	var c: CacaCanvas

	init
	do
		x = c.width / 2
		y = c.height / 2
		#print "center {x}, y{y}"
	end

	redef fun visit(node) do
		node.accept(self)
		#print "{x}, {y} @ {angle}"
	end
end

redef class Node
	fun accept(v: Interp) do visit_children(v)
end

redef class Nn
	fun value: Int
	do
		return text.first.code_point - 'Ⅰ'.code_point + 1
	end
end

redef class Ncmd_fw
	redef fun accept(v)
	do
		var ox = v.x
		var oy = v.y
		var n = n_n.value.to_f
		var a = v.angle.to_f / 6.0 * pi
		v.x += (a.cos * n).to_i
		v.y -= (a.sin * n).to_i
		v.c.draw_line(ox, oy, v.x, v.y)
	end
end

redef class Ncmd_tl
	redef fun accept(v)
	do
		var n = n_n.value
		v.angle += n
	end
end

redef class Ncmd_tr
	redef fun accept(v)
	do
		var n = n_n.value
		v.angle -= n
	end
end

redef class Ncmd_rp
	redef fun accept(v)
	do
		var n = n_n.value
		for i in [0..n] do v.enter_visit(n_cmds)
	end
end

var text = args.first.to_path.read_all

var d = new CacaDisplay
var c = d.canvas

var l = new Lexer_logolas(text)
var tokens = l.lex

var p = new Parser_logolas
p.tokens.add_all(tokens)
var node = p.parse

var i = new Interp(c)
i.enter_visit(node)
d.refresh
d.quit
