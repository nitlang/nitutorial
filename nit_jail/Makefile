install: diff ../logolas_parser.nit cacadev
	npm install

# The `diff` program is used to associate an input to a mission
diff:
	nitc ../diff.nit

# Generated nitcc file are required for nitcc/logolas missions
../logolas_parser.nit:
	cd .. && nitcc logolas.sablecc

# The devel files are required for ffi/caca missions
cacadev:
	pkg-config --exists caca || sudo apt-get install libcaca-dev

install-deps:
	git clone https://github.com/netblue30/firejail.git
	cd firejail && ./configure && make && sudo make install-strip

run:
	npm start

test:
	./localtest.sh ../*.nit
