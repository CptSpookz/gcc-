CC = gcc
LX = flex
LXLIB = -lfl
LXSRC = scanner.l
LXOBJ = lex.yy.c
OUT = gcc-

scanner:
	$(LX) $(LXSRC)
	$(CC) $(LXOBJ) -o $(OUT) $(LXLIB)

all: scanner

run:
	./$(OUT)

.PHONY: clean

clean: 
	rm ./$(LXOBJ) ./$(OUT)
