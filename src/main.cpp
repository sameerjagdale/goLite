#include<goParser.hpp>
#include<goLexer.hpp>
int main(int argc, char* argv[]) {
		yyin = fopen(argv[1], "r");	
		yyparse();
}
