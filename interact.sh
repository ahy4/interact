#!/bin/bash

cmd=$1
count=-1
history=""
while IFS= read -r -n1 -s char; do
  if [[ $char == $'\x1b' ]]; then
    read -r -n2 -s rest
    char+="$rest"
  fi
  case $char in
    $'\x1b\x5b\x41' ) # ↑
      # 一つ上のhistoryを表示
      count=`expr $count + 1`
      echo -e $history | tail -n $count | head -n1 ;;
    $'\x1b\x5b\x42' ) # ↓
      count=`expr $count - 1`
      echo -e $history | tail -n $count | head -n1 ;;
    $'\x1b\x5b\x43' ) # →
      echo → ;;
    $'\x1b\x5b\x44' ) # ←
      echo ← ;;
    [0-9] )
      echo "cmd"$char &&
      echo -e "history: "$history &&
      history=$history"cmd"$char"\n" ;;

    * )
      echo -n $char ;;
  esac
done

# read args
# while test "$args" != "a"
# do
#   line=$cmd" "$args
#   `echo $line`
#   read args
# done
