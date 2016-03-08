import logo_test_parser
import caca


class Interp
	super Visitor

	var x = 0.0
	var y = 0.0
	var angle: Float = 0.0 # pi / 2.0

	var c: CacaCanvas

	init
	do
		x = (c.width / 2).to_f
		y = (c.height / 2).to_f
	end

	redef fun visit(node) do
		node.accept(self)
		print "{x}.{y} @ {angle}"
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
		v.x += v.angle.cos * n
		v.y += v.angle.sin * n
		v.c.draw_line(ox.to_i, oy.to_i, v.x.to_i, v.y.to_i)
	end
end

redef class Ncmd_tl
	redef fun accept(v)
	do
		var n = n_n.value.to_f
		v.angle += n / 6.0 * pi
	end
end

redef class Ncmd_tr
	redef fun accept(v)
	do
		var n = n_n.value.to_f
		v.angle -= n / 6.0 * pi
	end
end

redef class Ncmd_rp
	redef fun accept(v)
	do
		var n = n_n.value
		for i in [0..n[ do v.enter_visit(n_cmds)
	end
end

var text = args.first.to_path.read_all

var d = new CacaDisplay
var c = d.canvas

var t = new TestParser_logo
var node = t.work(text)
var i = new Interp(c)
i.enter_visit(node)

c.put("Hello", 0, 0)
d.refresh
d.quit

