#include "s21_grep.h"

int main(int argc, char *argv[]) {
  if (argc > 2) {
    s21_grep(argc, argv);
  } else {
    printf("grep: not enough arguments\n");
  }
  return 0;
}

void s21_grep(int argc, char *argv[]) {
  Flags flags;
  init_flags(&flags);

  char pattern[8192] = {'\0'};

  get_flags(argv, &flags, pattern, argc);

  flags.files = argc - optind;

  for (; optind < argc; optind++) {
    FILE *name = fopen(argv[optind], "r");
    if (name != NULL) {
      output(argv, pattern, name, &flags);
    } else {
      if (!flags.s) {
        printf("grep: %s: No such file or directory\n", argv[optind]);
      }
      continue;
    }
    fclose(name);
  }
}

void init_flags(Flags *flags) {
  flags->e = 0;
  flags->i = 0;
  flags->v = 0;
  flags->c = 0;
  flags->l = 0;
  flags->n = 0;
  flags->h = 0;
  flags->s = 0;
  flags->f = 0;
  flags->o = 0;
  flags->files = 0;
}

void get_flags(char *argv[], Flags *flags, char *pattern, int argc) {
  int count = 0;
  const char *options = "e:f:ivclnhso";

  while (1) {
    int flag;
    flag = getopt(argc, argv, options);
    if (flag == -1) {
      break;
    }
    switch (flag) {
      case 'e':
        flags->e = 1;
        pattern_e(count, pattern);
        count++;
        break;
      case 'i':
        flags->i = 1;
        break;
      case 'v':
        flags->v = 1;
        break;
      case 'c':
        flags->c = 1;
        break;
      case 'l':
        flags->l = 1;
        break;
      case 'n':
        flags->n = 1;
        break;
      case 'h':
        flags->h = 1;
        break;
      case 's':
        flags->s = 1;
        break;
      case 'f':
        flags->f = 1;
        pattern_f(pattern);
        break;
      case 'o':
        flags->o = 1;
        break;
      default:
        printf("Usage: grep [OPTION]... PATTERNS [FILE]...\n");
        printf("Try 'grep --help' for more information.\n");
        exit(1);
    }
  }
  if ((!flags->e) && (!flags->f)) {
    strcat(pattern, argv[optind]);
    optind++;
  }
}

void output(char *argv[], char *pattern, FILE *name, Flags *flags) {
  regex_t regex;

  int counter = 0;
  size_t line = 1;

  regmatch_t pmatch[1] = {0};
  size_t nmatch = 1;

  int regflag = REG_EXTENDED;

  if (flags->i == 1) {
    regflag |= REG_ICASE;
  }

  regcomp(&regex, pattern, regflag);
  int check;

  char temp[8192] = {"/0"};
  while (!feof(name)) {
    if (fgets(temp, 8192, name)) {
      check = regexec(&regex, temp, nmatch, pmatch, 0);
      if (flags->v) check = check ? 0 : 1;
      if (check != REG_NOMATCH) {
        if (!flags->c && !flags->l) {
          if (flags->files > 1 && !flags->h) {
            printf("%s:", argv[optind]);
          }
          if (flags->n) {
            flag_n(line);
          }
          int o_counter = 1;
          if (flags->o && !flags->v) {
            o_counter = 0;
            char *ptr = temp;
            while (!check) {
              if (pmatch[0].rm_eo == pmatch[0].rm_so) {
                break;
              }
              printf("%.*s\n", (int)(pmatch[0].rm_eo - pmatch[0].rm_so),
                     ptr + pmatch[0].rm_so);
              ptr = pmatch[0].rm_eo + ptr;
              check = regexec(&regex, ptr, nmatch, pmatch, REG_NOTBOL);
            }
          }
          if (!flags->o || flags->v) {
            printf("%s", temp);
          }
          if (temp[strlen(temp) - 1] != '\n' && o_counter) {
            printf("\n");
          }
        }
        counter++;
      }
      line++;
    }
  }

  if (flags->c) {
    if (flags->files > 1 && !flags->h) {
      printf("%s:", argv[optind]);
    }
    flag_c(counter);
  }

  if (flags->l && counter) {
    printf("%s\n", argv[optind]);
  }

  regfree(&regex);
}

void flag_n(size_t line) { printf("%lu:", line); }

void flag_c(int matched_line) { printf("%d\n", matched_line); }

void pattern_e(int count, char *pattern) {
  if (count > 0) {
    strcat(pattern, "|");
  }
  strcat(pattern, optarg);
}

void pattern_f(char *pattern) {
  FILE *name = fopen(optarg, "r");

  if (name) {
    char temp[8192] = {"\0"};
    int count = 0;
    while (!feof(name)) {
      if (fgets(temp, 8192, name)) {
        if (temp[strlen(temp) - 1] == '\n') {
          temp[strlen(temp) - 1] = 0;
        }
        if (count > 0) {
          strcat(pattern, "|");
        }
        strcat(pattern, temp);
        count++;
      }
    }
  } else {
    printf("grep: %s: No such file or directory\n", optarg);
    exit(1);
  }
  fclose(name);
}