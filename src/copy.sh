#!/bin/bash

scp cat/s21_cat alex@192.168.0.3:~/
scp grep/s21_grep alex@192.168.0.3:~/

ssh -p 22 alex@192.168.0.3 mv s21_cat /usr/local/bin
ssh -p 22 alex@192.168.0.3 mv s21_grep /usr/local/bin
