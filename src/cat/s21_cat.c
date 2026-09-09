#include "s21_cat.h"

int main(int argc, char *argv[]) {
  if (argc > 1) {
    s21_cat(argc, argv);
  } else {
    printf("cat: not enough arguments\n");
  }
  return 0;
}

void s21_cat(int argc, char *str[]) {
  Flags flags;
  init_flags(&flags);

  int error = 0;
  int i = 1;

  for (; i < argc; ++i) {
    if (strspn(str[i], "-") == 0) {
      break;
    }
    if (get_flags(str[i], &flags) == 1) {
      error = 1;
    }
  }

  for (; i < argc; ++i) {
    FILE *name = fopen(str[i], "r");
    if (name == NULL) {
      printf("cat: %s: No such file or directory\n", str[i]);
      continue;
    }
    if (!error) {
      int count_all_lines = 1;
      int count_non_empty_lines = 1;
      char temp[8192] = {'\0'};
      char previous_char = '\n';
      char next_char = ' ';
      int t_check = 0;
      int v_check = 0;

      while ((*temp = fgetc(name)) != EOF) {
        v_check = 0;
        if (flags.s && flag_s(previous_char, next_char, *temp)) {
          continue;
        }
        if (flags.n && !flags.b && !t_check) {
          flag_n(previous_char, &count_all_lines);
        }
        if (flags.b && !t_check) {
          flag_b(previous_char, &count_non_empty_lines, *temp);
        }
        t_check = 0;
        if (flags.T && flag_T(*temp)) {
          t_check = 1;
          continue;
        }
        if (flags.t && flag_T(*temp)) {
          t_check = 1;
          v_check = flag_v(temp, &v_check);
          continue;
        }
        if (flags.E) {
          flag_E(*temp);
        }
        if (flags.e) {
          flag_E(*temp);
          v_check = flag_v(temp, &v_check);
        }
        if (flags.v) {
          v_check = flag_v(temp, &v_check);
        }

        next_char = previous_char;
        previous_char = *temp;
        if (!v_check) {
          if (*temp == '\0') {
            fputc(*temp, stdout);
          } else {
            fputs(temp, stdout);
          }
        }
      }
    }
    fclose(name);
  }
}

void init_flags(Flags *flags) {
  flags->b = 0;
  flags->e = 0;
  flags->E = 0;
  flags->v = 0;
  flags->n = 0;
  flags->s = 0;
  flags->t = 0;
  flags->T = 0;
}

int get_flags(char *str, Flags *flags) {
  int error = 0;
  int check = 0;
  if (strcmp(str, "--number-nonblank") == 0 || strcmp(str, "--number") == 0 ||
      strcmp(str, "--squeeze-blank") == 0) {
    check = 1;
  } else if (strlen(str) < 1 || strlen(str) != strspn(str, "-beEvnsTt")) {
    error = 1;
    printf("cat: invalid option -- '%s'\n", str);
    printf("Try 'cat --help' for more information.\n");
  }
  if (check) {
    if (strcmp(str, "--number-nonblank") == 0) {
      flags->b = 1;
    } else if (strcmp(str, "--number") == 0) {
      flags->n = 1;
    } else if (strcmp(str, "--squeeze-blank") == 0) {
      flags->s = 1;
    }
  } else {
    if (strchr(str, 'b')) {
      flags->b = 1;
    } else if (strchr(str, 'e')) {
      flags->v = 1;
      flags->E = 1;
    } else if (strchr(str, 'E')) {
      flags->E = 1;
    } else if (strchr(str, 'v')) {
      flags->v = 1;
    } else if (strchr(str, 'n')) {
      flags->n = 1;
    } else if (strchr(str, 's')) {
      flags->s = 1;
    } else if (strchr(str, 't')) {
      flags->v = 1;
      flags->T = 1;
    } else if (strchr(str, 'T')) {
      flags->T = 1;
    }
  }
  return error;
}

void flag_b(char previous_char, int *count_non_empty_lines, char ch) {
  if (previous_char == '\n' && ch != '\n') {
    printf("%6d\t", (*count_non_empty_lines)++);
  }
}

void flag_E(char ch) {
  if (ch == '\n') {
    printf("$");
  }
}

int flag_v(const char *ch, int *v_check) {
  if (*ch != '\n' && *ch != '\t') {
    if ((*ch > 0 && *ch < 9) || (*ch > 10 && *ch <= 31)) {
      printf("^%c", *ch + 64);
      *v_check = 1;
    } else if (*ch == 127) {
      printf("^%c", *ch - 64);
      *v_check = 1;
    }
  }
  return *v_check;
}

void flag_n(char previous_char, int *count_all_lines) {
  if (previous_char == '\n') {
    printf("%6d\t", (*count_all_lines)++);
  }
}

int flag_s(char previous_char, char next_char, char ch) {
  return previous_char == '\n' && ch == '\n' && next_char == '\n';
}

int flag_T(char ch) {
  int tab = 0;
  if (ch == '\t') {
    tab = printf("^I");
  }
  return tab;
}
