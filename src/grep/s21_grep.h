#ifndef SRC_GREP_S21_GREP_H_
#define SRC_GREP_S21_GREP_H_

#include <getopt.h>
#include <regex.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
  int e;
  int i;
  int v;
  int c;
  int l;
  int n;
  int h;
  int s;
  int f;
  int o;
  int files;

} Flags;

void s21_grep(int argc, char *argv[]);
void init_flags(Flags *flags);
void get_flags(char *argv[], Flags *flags, char *pattern, int argc);
void output(char *argv[], char *pattern, FILE *name, Flags *flags);
void flag_n(size_t line);
void flag_c(int matched_line);
void pattern_e(int count, char *pattern);
void pattern_f(char *pattern);

#endif  // SRC_GREP_S21_GREP_H_