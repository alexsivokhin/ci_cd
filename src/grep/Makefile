CC = gcc
FLAGS = -Wall -Werror -Wextra -std=c11
SOURCES = s21_grep.c

all: s21_grep

s21_grep:
	$(CC) $(FLAGS) $(SOURCES) -o s21_grep

test: s21_grep
	sh test_grep.sh

lint:
	@cp ../../materials/linters/.clang-format .clang-format
	clang-format -n *.c *.h
	@rm -rf .clang-format

valgrind: s21_grep
	valgrind --leak-check=full \
	--show-leak-kinds=all \
	--track-origins=yes \
	--verbose \
	--log-file=valgrind-out.txt \
	./s21_grep -f pattern.txt test.txt

cppcheck:
	cppcheck --enable=all --inconclusive s21*.c s21*.h

clean: 
	rm -rf s21_grep valgrind-out.txt

rebuild: clean all