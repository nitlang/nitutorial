
# The base classes with the static knowledge about tutorial and exercises
module tuto

import markdown
import ini
import poset

# The main knowledge about lessons and exercises
class Tutorial
	# Dictionary of exercises by the internal name and the title id.
	var exercise_by_name = new HashMap[String, Exercise]

	# Hierarchy of exercise dependencies
	var poset = new POSet[Exercise]

	# A poor man's database
	var db = new ConfigTree("save.ini")

	# Load a bunch of tracks from a directory
	fun load(path: String) do
		var files = path.files.to_a
		default_comparator.sort(files)

		var exercises = new Array[Exercise]

		for f in files do
			var ff = path / f
			var mission = ff / "mission.md"
			if not mission.file_exists then continue
			var ini = new ConfigTree(ff / "config.ini")

			var name = f.basename
			var title = ini["title"]
			if title == null then
				print_error "{name}: no title in {ini}"
				title = name
			end

			var content = mission.to_path.read_all
			if content.is_empty then print_error "{name}: no {mission}"
			var proc = new MarkdownProcessor
			var html = proc.process(content).write_to_string

			var tmpl = (ff / "template.nit").to_path.read_all

			var title_id = title.strip_id

			var e = new Exercise(name, ff, title, title_id, html, ini, tmpl)

			print "{ff}: got «{e.title}»"
			exercise_by_name[title_id] = e
			exercise_by_name[name] = e

			exercises.add e
		end

		for e in exercises do
			poset.add_node e
			var reqs = e.ini["req"]
			if reqs != null then
				for r in reqs.split(",") do
					r = r.trim
					var re = exercise_by_name.get_or_null(r)
					if re == null then
						print_error "{e}: unknown requirement {r}"
					else if poset.has_edge(re, e) then
						print_error "{e}: circular requirement with {re}"
					else
						poset.add_edge(e, re)
					end
				end
			end
		end
	end
end

# A single exercise of the tutorial
class Exercise
	# The internal name
	#
	# Is not exposed to the user but is used internally
	# to name the directory and 
	var name: String

	# The directory with the various files
	var filepath: String

	# The full title
	# (loaded from the ini)
	var title: String

	# The identifier exposed to the user.
	#
	# Is a `strip_id` version of the `title`.
	var title_id: String

	# The full subject in HTML.
	var subject: Writable

	# The .ini file with configuration
	var ini: ConfigTree

	# The raw template (used as a default code) 
	var template: String

	redef fun to_s do return name
end


redef class String
	# Replace sequences of non-alphanumerical characters by underscore.
	#
	# ~~~
	# assert "abcXYZ123_" == "abcXYZ123_"
	# assert ", 'A[]\nB#$_" == "A_B"
	# ~~~
	fun strip_id: String
	do
		var res = new Buffer
		var sp = false
		for c in chars do
			if not c.is_alpha then
				sp = true
				continue
			end
			if sp then
				res.add '_'
				sp = false
			end
			res.add c
		end
		return res.to_s
	end
end


redef class HTMLDecorator
	redef fun add_link(v, link, name, comment)
	do
		# Keep absolute links as is
		if link.has_prefix("http://") or link.has_prefix("https://") then
			super
			return
		end
		print "link {link}"
		super
	end
end


var pages = "../tracks"
var tutorial = new Tutorial
tutorial.load(pages)
