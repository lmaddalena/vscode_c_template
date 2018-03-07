CC = gcc

CFLAGS = -g -Wall -Werror -Isrc -std=c99 -O2
LDFLAGS =  
TARGET = bin/a.out

TEST_SRCS=$(wildcard tests/*_tests.c)
TESTS=$(patsubst %.c,%,$(TEST_SRCS))

all: $(TARGET) tests

$(TARGET): build/main.o
	$(CC) $(LDFLAGS) $^ -o $@

build/main.o: src/main.c src/stda.h
	$(CC) $(CFLAGS) -c $< -o $@

tests: $(TESTS)
	sh ./tests/runtests.sh

clean:
	rm -f build/* bin/*
	rm -f $(TESTS)

.PHONY: all tests clean