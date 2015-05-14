#include<goParser.hpp>
#include<goLexer.hpp>
#include<iostream>
#include<node-visitor.hpp>
#include<ast.hpp>
using namespace GCompiler;
int main(int argc, char* argv[]) {
		yyin = fopen(argv[1], "r");	
		int res = yyparse();
		exit(res);
}
