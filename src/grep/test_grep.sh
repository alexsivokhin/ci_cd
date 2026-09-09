#!/bin/bash
SETCOLOR_SUCCESS="echo \\033[1;32m"
SETCOLOR_FAILURE="echo \\033[1;31m"
SETCOLOR_NORMAL="echo \\033[0;39m"

NUM_SUCCESS=0
NUM_FAIL=0
NUM_TOTAL=0

file="test.txt"
pattern_e="kek LoL net"
pattern="kek doesnt_exist"
regular="'[A-Za-z0-9]' '[A-Za-z0-9_]' '[0-9]' '[^0-9]' '[a-z]' '[^\t\r\n\v\f]'"

# without flag - 1 file 
for pattern_1 in $pattern $regular
do
  ./s21_grep $pattern_1 $file > s21_grep.txt
  grep $pattern_1 $file > grep.txt
  res="$(diff -s s21_grep.txt grep.txt)"
  if [ "$res" = "Files s21_grep.txt and grep.txt are identical" ]
    then
      ${SETCOLOR_SUCCESS}
      NUM_SUCCESS=$(( NUM_SUCCESS + 1 ))
      NUM_TOTAL=$(( NUM_TOTAL + 1 ))
      echo "$NUM_TOTAL. $pattern_1 $file"
      ${SETCOLOR_NORMAL}
    else
      ${SETCOLOR_FAILURE}
      NUM_FAIL=$(( NUM_FAIL+ 1 ))
      NUM_TOTAL=$(( NUM_TOTAL+ 1 ))
      echo "$NUM_TOTAL. $pattern_1 $file"
      ${SETCOLOR_NORMAL}
        exit 1;
  fi
  rm s21_grep.txt grep.txt
done

# without flag - 2 files
file="test.txt pattern.txt"
for pattern_1 in $pattern $regular
do
  ./s21_grep $pattern_1 $file > s21_grep.txt
  grep $pattern_1 $file > grep.txt
  res="$(diff -s s21_grep.txt grep.txt)"
  if [ "$res" = "Files s21_grep.txt and grep.txt are identical" ]
    then
      ${SETCOLOR_SUCCESS}
      NUM_SUCCESS=$(( NUM_SUCCESS + 1 ))
      NUM_TOTAL=$(( NUM_TOTAL + 1 ))
      echo "$NUM_TOTAL. $pattern_1 $file"
      ${SETCOLOR_NORMAL}
    else
      ${SETCOLOR_FAILURE}
      NUM_FAIL=$(( NUM_FAIL+ 1 ))
      NUM_TOTAL=$(( NUM_TOTAL+ 1 ))
      echo "$NUM_TOTAL. $pattern_1 $file"
      ${SETCOLOR_NORMAL}
        exit 1;
  fi
  rm s21_grep.txt grep.txt
done

# with 1 flag - 1 file
file="test.txt"
for flag in h n i v c l s o
do
  for pattern in $pattern $regular
    do
      ./s21_grep -$flag $pattern $file > s21_grep.txt
      grep -$flag $pattern $file > grep.txt
      res="$(diff -s s21_grep.txt grep.txt)"
      if [ "$res" = "Files s21_grep.txt and grep.txt are identical" ]
        then
          ${SETCOLOR_SUCCESS}
          NUM_SUCCESS=$(( NUM_SUCCESS + 1 ))
          NUM_TOTAL=$(( NUM_TOTAL + 1 ))
          echo "$NUM_TOTAL. -$flag $pattern $file"
          ${SETCOLOR_NORMAL}
        else
          ${SETCOLOR_FAILURE}
          NUM_FAIL=$(( NUM_FAIL+ 1 ))
          NUM_TOTAL=$(( NUM_TOTAL+ 1 ))
          echo "$NUM_TOTAL. -$flag $pattern $file"
          ${SETCOLOR_NORMAL}
           exit 1;
      fi
      rm s21_grep.txt grep.txt
  done
done

# with 1 flag - 2 files
file="test.txt pattern.txt"
for flag in h n i v c l s o
do
  for pattern in $pattern $regular
    do
      ./s21_grep -$flag $pattern $file > s21_grep.txt
      grep -$flag $pattern $file > grep.txt
      res="$(diff -s s21_grep.txt grep.txt)"
      if [ "$res" = "Files s21_grep.txt and grep.txt are identical" ]
        then
          ${SETCOLOR_SUCCESS}
          NUM_SUCCESS=$(( NUM_SUCCESS + 1 ))
          NUM_TOTAL=$(( NUM_TOTAL + 1 ))
          echo "$NUM_TOTAL. -$flag $pattern $file"
          ${SETCOLOR_NORMAL}
        else
          ${SETCOLOR_FAILURE}
          NUM_FAIL=$(( NUM_FAIL+ 1 ))
          NUM_TOTAL=$(( NUM_TOTAL+ 1 ))
          echo "$NUM_TOTAL. -$flag $pattern $file"
          ${SETCOLOR_NORMAL}
           exit 1;
      fi
      rm s21_grep.txt grep.txt
  done
done

# with flags - 1 file
file="test.txt"
for flag_1 in h n i v c s
do
  for flag_2 in e h n i v c s
  do
      if [ $flag_1 != $flag_2 ]
      then
        for pattern in $patterns $regular
        do
          ./s21_grep -$flag_1$flag_2 $pattern $file > s21_grep.txt
          grep -$flag_1$flag_2 $pattern $file > grep.txt
          res="$(diff -s s21_grep.txt grep.txt)"
          if [ "$res" = "Files s21_grep.txt and grep.txt are identical" ]
          then
            ${SETCOLOR_SUCCESS}
            NUM_SUCCESS=$(( NUM_SUCCESS + 1 ))
            NUM_TOTAL=$(( NUM_TOTAL + 1 ))
            echo "$NUM_TOTAL. -$flag_1$flag_2 $pattern $file "
            ${SETCOLOR_NORMAL}
          else
            ${SETCOLOR_FAILURE}
            NUM_FAIL=$(( NUM_FAIL+ 1 ))
            NUM_TOTAL=$(( NUM_TOTAL+ 1 ))
            echo "$NUM_TOTAL. | failed | -$flag_1$flag_2 $pattern $file "
            ${SETCOLOR_NORMAL}
            exit 1;
          fi
          rm s21_grep.txt grep.txt
        done
      fi
  done
done

# with flags - 2 files
file="test.txt pattern.txt"
for flag_1 in h n i l s o
do
  for flag_2 in e h n i l s o
  do
      if [ $flag_1 != $flag_2 ]
      then
        for pattern in $patterns $regular
        do
          ./s21_grep -$flag_1$flag_2 $pattern $file > s21_grep.txt
          grep -$flag_1$flag_2 $pattern $file > grep.txt
          res="$(diff -s s21_grep.txt grep.txt)"
          if [ "$res" = "Files s21_grep.txt and grep.txt are identical" ]
          then
            ${SETCOLOR_SUCCESS}
            NUM_SUCCESS=$(( NUM_SUCCESS + 1 ))
            NUM_TOTAL=$(( NUM_TOTAL + 1 ))
            echo "$NUM_TOTAL. -$flag_1$flag_2 $pattern $file "
            ${SETCOLOR_NORMAL}
          else
            ${SETCOLOR_FAILURE}
            NUM_FAIL=$(( NUM_FAIL+ 1 ))
            NUM_TOTAL=$(( NUM_TOTAL+ 1 ))
            echo "$NUM_TOTAL. | failed | -$flag_1$flag_2 $pattern $file "
            ${SETCOLOR_NORMAL}
            exit 1;
          fi
          rm s21_grep.txt grep.txt
        done
      fi
  done
done

# flag e 1 file
flag_e="-e"
file="test.txt"
for pattern_1 in $pattern_e $regular
do
  for pattern_2 in $pattern_e $regular
  do
    for pattern_3 in $pattern_e $regular
    do
      ./s21_grep $flag_e $pattern_1 $flag_e $pattern_2 $flag_e $pattern_3 $file > s21_grep.txt
      grep $flag_e $pattern_1 $flag_e $pattern_2 $flag_e $pattern_3 $file > grep.txt
      res="$(diff -s s21_grep.txt grep.txt)"
      if [ "$res" = "Files s21_grep.txt and grep.txt are identical" ]
        then
          ${SETCOLOR_SUCCESS}
          NUM_SUCCESS=$(( NUM_SUCCESS + 1 ))
          NUM_TOTAL=$(( NUM_TOTAL + 1 ))
          echo "$NUM_TOTAL. $flag_e $pattern_1 $flag_e $pattern_2 $flag_e $pattern_3 $file"
          ${SETCOLOR_NORMAL}
        else
          ${SETCOLOR_FAILURE}
          NUM_FAIL=$(( NUM_FAIL+ 1 ))
          NUM_TOTAL=$(( NUM_TOTAL+ 1 ))
          echo "$NUM_TOTAL. | failed | $flag_e $pattern_1 $flag_e $pattern_2 $flag_e $pattern_3 $file"
          ${SETCOLOR_NORMAL}
           exit 1;
      fi
      rm s21_grep.txt grep.txt
    done
  done
done

# flag e 2 files
flag_e="-e"
file="test.txt pattern.txt"

for pattern_1 in $pattern_e $regular
do
  for pattern_2 in $pattern_e $regular
  do
    for pattern_3 in $pattern_e $regular
    do
      ./s21_grep $flag_e $pattern_1 $flag_e $pattern_2 $flag_e $pattern_3 $file > s21_grep.txt
      grep $flag_e $pattern_1 $flag_e $pattern_2 $flag_e $pattern_3 $file > grep.txt
      res="$(diff -s s21_grep.txt grep.txt)"
      if [ "$res" = "Files s21_grep.txt and grep.txt are identical" ]
        then
          ${SETCOLOR_SUCCESS}
          NUM_SUCCESS=$(( NUM_SUCCESS + 1 ))
          NUM_TOTAL=$(( NUM_TOTAL + 1 ))
          echo "$NUM_TOTAL. $flag_e $pattern_1 $flag_e $pattern_2 $flag_e $pattern_3 $file"
          ${SETCOLOR_NORMAL}
        else
          ${SETCOLOR_FAILURE}
          NUM_FAIL=$(( NUM_FAIL+ 1 ))
          NUM_TOTAL=$(( NUM_TOTAL+ 1 ))
          echo "$NUM_TOTAL. | failed | $flag_e $pattern_1 $flag_e $pattern_2 $flag_e $pattern_3 $file"
          ${SETCOLOR_NORMAL}
          exit 1;
      fi
      rm s21_grep.txt grep.txt
    done
  done
done

# flag - f
file="test.txt"
pattern_file="pattern.txt"

./s21_grep -f $pattern_file $file > s21_grep.txt
grep -f $pattern_file $file > grep.txt
res="$(diff -s s21_grep.txt grep.txt)"
if [ "$res" = "Files s21_grep.txt and grep.txt are identical" ]
  then
    ${SETCOLOR_SUCCESS}
    NUM_SUCCESS=$(( NUM_SUCCESS + 1 ))
    NUM_TOTAL=$(( NUM_TOTAL + 1 ))
    echo "$NUM_TOTAL. $pattern_1 $file"
    ${SETCOLOR_NORMAL}
  else
    ${SETCOLOR_FAILURE}
    NUM_FAIL=$(( NUM_FAIL+ 1 ))
    NUM_TOTAL=$(( NUM_TOTAL+ 1 ))
    echo "$NUM_TOTAL. $pattern_1 $file"
    ${SETCOLOR_NORMAL}
      exit 1;
fi
rm s21_grep.txt grep.txt


# flag s
file="test.txt pattern doesnt_exist"
flag="s"
for pattern in $patterns $regular
  do
    ./s21_grep -$flag $pattern $file > s21_grep.txt
    grep -$flag $pattern $file > grep.txt
    res="$(diff -s s21_grep.txt grep.txt)"
    if [ "$res" = "Files s21_grep.txt and grep.txt are identical" ]
      then
        ${SETCOLOR_SUCCESS}
        NUM_SUCCESS=$(( NUM_SUCCESS + 1 ))
        NUM_TOTAL=$(( NUM_TOTAL + 1 ))
        echo "$NUM_TOTAL. -$flag $pattern $file"
        ${SETCOLOR_NORMAL}
      else
        ${SETCOLOR_FAILURE}
        NUM_FAIL=$(( NUM_FAIL+ 1 ))
        NUM_TOTAL=$(( NUM_TOTAL+ 1 ))
        echo "$NUM_TOTAL. | failed | -$flag $pattern $file"
        ${SETCOLOR_NORMAL}
        exit 1;
    fi
    rm s21_grep.txt grep.txt
done

# with flags - * files
file="*.txt"
for flag_1 in h n i l s o
do
  for flag_2 in h n i l s o
  do
      if [ $flag_1 != $flag_2 ]
      then
        for pattern in $patterns $regular
        do
          ./s21_grep -$flag_1$flag_2 $pattern $file > ../s21_grep.txt
          grep -$flag_1$flag_2 $pattern $file > ../grep.txt
          res="$(diff -s ../s21_grep.txt ../grep.txt)"
          if [ "$res" = "Files ../s21_grep.txt and ../grep.txt are identical" ]
          then
            ${SETCOLOR_SUCCESS}
            NUM_SUCCESS=$(( NUM_SUCCESS + 1 ))
            NUM_TOTAL=$(( NUM_TOTAL + 1 ))
            echo "$NUM_TOTAL. -$flag_1$flag_2 $pattern $file "
            ${SETCOLOR_NORMAL}
          else
            ${SETCOLOR_FAILURE}
            NUM_FAIL=$(( NUM_FAIL+ 1 ))
            NUM_TOTAL=$(( NUM_TOTAL+ 1 ))
            echo "$NUM_TOTAL. | failed | -$flag_1$flag_2 $pattern $file "
            ${SETCOLOR_NORMAL}
            exit 1;
          fi
          rm ../s21_grep.txt ../grep.txt
        done
      fi
  done
done

echo "-------------------------------------------
Total $NUM_TOTAL
Success: $NUM_SUCCESS | Fail: $NUM_FAIL"
