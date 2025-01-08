# CC:			compiler to use
# CFFLAGS:		compiler flags:
#					-std=c99: enforces C99 language standard compliance
#					-g: enables generating debugging information in the compiled code
#					-Wall: instructs the compiler to warn about potential errors and warnings in the code
#					-Isrc: adds the src directory to the compiler's include search path, allowing it to find header files located there		
#					-Werror: treats all warnings as errors, causing the compilation to fail if any warnings are generated
# LDFLAGS:		defines the linker flags that will be passed to the linker when creating the final executable:
#					-lpthread: links the program with the pthread library, which provides functions for multithreading
#					-ldl: links the program with the dynamic linker library
#					-lsqlite3: links the program with the SQLite3 library
#					-lm: links the math library
# TARGET:			name of the final executable file
# LIB_DIR:			specifies the directory containing libraries used by the program
# BUILD_DIR:		specifies the directory where intermediate object files will be created during compilation
# BIN_DIR:			specifies the directory where the final executable will be placed
# SRCS:				this variable uses shell globbing to find all .c files in the src directory and any subdirectories		
# OBJS: 			this variable uses a pattern rule to transform the list of source files (SRCS) into a list of object files by replacing the .c extension with .o
# .PHONY:			tells Make that the listed targets (in this case, all and tests) are phony targets. Phony targets are targets that don't correspond to actual files on disk but are used to control the execution flow of the Makefile
#
# RULES:
# --------------------------------------------------------------------------------------------------------
# all:				this is the default target in the Makefile. 
#					It specifies that when you run make without any arguments, the tasks listed here will be executed. 
#					In this case, it depends on two other targets: $(TARGET) (the final executable) and tests (which presumably builds and runs tests)
# $(TARGET): 		This rule defines how to build the final executable. It depends on two things:
#						- All the object files ($(OBJS)) listed in the OBJS variable.
#						- The existence of the $(LIB_DIR) directory (and presumably any libraries it contains). The commands to create the executable are:
#						- $(CC) $(CFLAGS) $^ -o $@ $(LDFLAGS): This line invokes the C compiler with the specified flags ($(CFLAGS)), followed by all the prerequisite files ($^) and the output filename ($@). 
#					  	  Finally, the linker flags ($(LDFLAGS)) are provided.
#						- mv $(OBJS) $(BUILD_DIR): This line moves all the object files ($(OBJS)) to the $(BUILD_DIR) directory after the compilation is complete.
# %.o: %.c: 		This is a pattern rule that defines how to compile individual source files into object files. 
#					For each source file (%.c), the following command is executed: * $(CC) $(CFLAGS) -c $< -o $@: 
#					This line compiles the source file ($<) with the specified flags ($(CFLAGS)) and creates an object file named after the source file but with a .o extension ($@).

CC = gcc
CFLAGS = -std=c99 -g -Wall -Isrc -Werror
LDFLAGS = -lpthread -ldl -lsqlite3
TARGET = $(BIN_DIR)/a.out

LIB_DIR = ./lib
BUILD_DIR = ./build
BIN_DIR = ./bin

SRCS = $(wildcard src/**/*.c src/*.c)
OBJS = $(patsubst %.c, %.o, $(SRCS))

TEST_SRCS = $(wildcard tests/*_tests.c)
TESTS = $(patsubst %.c, %, $(TEST_SRCS))

all: $(TARGET) tests

$(TARGET): $(OBJS) #$(LIB_DIR)/**/*.o
	$(CC) $(CFLAGS) $^ -o $@ $(LDFLAGS) 
	mv $(OBJS) $(BUILD_DIR)

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

tests: $(TESTS)
	sh ./tests/runtests.sh

clean:
	rm -f $(BUILD_DIR)/* $(BIN_DIR)/*
	rm -f $(TESTS)

.PHONY: all tests clean