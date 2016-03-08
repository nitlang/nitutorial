
all: logo

logo: logo.nit logo_test_parser.nit
	nitc logo.nit


logo_test_parser.nit: logo.sablecc
	nitcc logo.sablecc

run: logo
	./logo e1.logo

tests: logo
	echo "" | CACA_DRIVER=ncurses ./logo e1.logo > e1.out
	cat -v e1.out
