all: gen compile 
compile : 
	g++ gen/*.cpp -o bin/goCompiler -I gen/	 -std=c++11
gen : grammar/goLex.l grammar/goParser.y	
	flex  -o gen/goLexer.cpp grammar/goLex.l
	bison -o gen/goParser.cpp grammar/goParser.y --defines 
