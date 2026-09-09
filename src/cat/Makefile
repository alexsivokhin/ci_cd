CC = gcc
FLAGS = -Wall -Werror -Wextra -std=c11
SOURCES = s21_cat.c

all: s21_cat

s21_cat:
	$(CC) $(FLAGS) $(SOURCES) -o s21_cat

test: s21_cat
	sh test_cat.sh

lint:
	@cp ../../materials/linters/.clang-format .clang-format
	clang-format -n *.c *.h
	@rm -rf .clang-format

valgrind: s21_cat
	valgrind --leak-check=full \
	--show-leak-kinds=all \
	--track-origins=yes \
	--verbose \
	--log-file=valgrind-out.txt \
	./s21_cat -b -e -n -s -t test.txt

cppcheck:
	cppcheck --enable=all --inconclusive *.c *.h

clean: 
	rm -rf s21_cat log.txt valgrind-out.txt

rebuild: clean all