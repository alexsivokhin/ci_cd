#ifndef SRC_CAT_S21_CAT_H_
#define SRC_CAT_S21_CAT_H_

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
  int b;
  int e;
  int E;
  int v;
  int n;
  int s;
  int t;
  int T;
} Flags;

void init_flags(Flags *flags);
int get_flags(char *str, Flags *flags);
void s21_cat(int argc, char *str[]);
void flag_b(char previous_char, int *count_non_empty_lines, char ch);
void flag_E(char ch);
int flag_v(const char *ch, int *v_check);
void flag_n(char previous_char, int *count_all_lines);
int flag_s(char previous_char, char next_char, char ch);
int flag_T(char ch);

#endif  // SRC_CAT_S21_CAT_H_