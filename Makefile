all:
	# The `diff` program is used to associacte an input to a mission
	nitc diff.nit --dir nit_jail
	# Generated nitcc file are required for logolas missions
	nitcc logolas.sablecc
	# The devel files are required for caca missions
	sudo apt-get install libcaca-dev
