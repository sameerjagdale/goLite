#include<goParser.hpp>
#include<goLexer.hpp>
#include<errno.h>
#include<iostream>
int main(int argc, char* argv[]) {
		yyin = fopen(argv[1], "r");	
		yyparse();
}
