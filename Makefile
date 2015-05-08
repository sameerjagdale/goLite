all: compile
compile : gen main.o
	g++  bin/*.o -o bin/goCompiler -I gen/	 -std=c++11
main.o : goLexer.o  src/main.cpp
	g++ -c src/main.cpp -o bin/main.o -I gen/ 
goLexer.o : gen/goParser.cpp gen/goLexer.cpp 
	g++ -c gen/goLexer.cpp -o bin/goLexer.o -I gen/
	g++ -c gen/goParser.cpp -o bin/goParser.o -I gen/ 
gen : grammar/goLex.l grammar/goParser.y	
	flex  --header-file=gen/goLexer.hpp -o gen/goLexer.cpp grammar/goLex.l 
	bison -o gen/goParser.cpp grammar/goParser.y --defines 
clean: 
	rm gen/* 
	bin/*
