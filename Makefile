parser: y.tab.c lex.yy.c
	gcc -o parser y.tab.c
y.tab.c: CS315_F23_Team63.y lex.yy.c
	yacc CS315_F23_Team63.y
lex.yy.c: CS315_F23_Team63.l
	lex CS315_F23_Team63.l
clean:
	rm -f lex.yy.c y.tab.c parser