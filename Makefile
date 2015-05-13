all:  compile
compile :  main.o
	g++  bin/*.o -o bin/goCompiler -I gen/	 -std=c++11
main.o : goLexer.o  src/main.cpp goParser.o
	g++ -c src/main.cpp -o bin/main.o -I gen/ 
goLexer.o : goLexer.cpp 
	g++ -c gen/goLexer.cpp -o bin/goLexer.o -I gen/
goParser.o : goParser.cpp
	g++ -c gen/goParser.cpp -o bin/goParser.o -I gen/ 
goParser.cpp: grammar/goParser.y
	bison -o gen/goParser.cpp grammar/goParser.y --defines 
goLexer.cpp: grammar/goLex.l goParser.cpp
	flex  --header-file=gen/goLexer.hpp -o gen/goLexer.cpp grammar/goLex.l 
clean: 
	rm gen/* 
	bin/*
