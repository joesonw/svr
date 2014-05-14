CXX = g++ $(CLAGS)
CFLAGS = -std=c++11 -g

prog: parser.tab.o lexer.o
	$(CXX) -o prog parser.tab.o lexer.o -ll -ly
parser.tab.c: parser.y
	bison -b parser -d parser.y
lexer.c: lexer.l
	flex -olexer.c lexer.l
parser.tab.o: parser.tab.c
	$(CXX) -Wall -c parser.tab.c
lexer.o: lexer.c
	$(CXX) -Wall -c lexer.c
clean:
	rm parser.tab.h lexer.c lex.yy.cc prog parser.tab.c *.o -f
