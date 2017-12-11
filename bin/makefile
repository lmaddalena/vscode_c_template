CC = gcc

CFLAGS = -std=c99 -g
LDFLAGS =
PROG = a.out

$(PROG): main.o
	$(CC) $(LDFLAGS) *.o -o $(PROG)

main.o: ../main.c ../stda.h
	$(CC) $(CFLAGS) -c ../main.c

all: $(PROG)

clean:
	rm -f $(PROG) *.o
