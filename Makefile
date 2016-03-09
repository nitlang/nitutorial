
all: logolas

logolas: logolas.nit logolas_test_parser.nit
	nitc logolas.nit


logolas_test_parser.nit: logolas.sablecc
	nitcc logolas.sablecc

run: logolas
	./logolas e1.logolas

tests: logolas
	echo "" | CACA_DRIVER=ncurses ./logolas e1.logolas > e1.out
	cat -v e1.out
